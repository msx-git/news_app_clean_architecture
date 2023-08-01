import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app/src/config/router/routes.dart';
import 'package:news_app/src/presentation/widgets/article_list.dart';
import 'package:news_app/src/utils/extensions/scroll_controller.dart';

import '../cubits/remote_articles/remote_articles_cubit.dart';

class BreakingNewsView extends HookWidget {
  const BreakingNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteArticlesCubit = BlocProvider.of<RemoteArticlesCubit>(context);
    final scrollController = useScrollController();
    useEffect(() {
      scrollController.onScrollEndsListener(() {
        remoteArticlesCubit.getBreakingNewsArticles();
      });
      return scrollController.dispose;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily News'),
        actions: [
          GestureDetector(
            onTap: () => context.push(Routes.savedArticles),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Ionicons.bookmark, color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocBuilder<RemoteArticlesCubit, RemoteArticlesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case RemoteArticlesLoading:
              return const Center(child: CupertinoActivityIndicator());
            case RemoteArticlesFailed:
              return const Center(child: Icon(Icons.refresh));
            case RemoteArticlesSuccess:
              return ArticleList(
                scrollController: scrollController,
                articles: state.articles,
                noMoreData: state.noMoreData,
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
