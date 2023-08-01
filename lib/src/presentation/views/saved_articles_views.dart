import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../domain/models/article.dart';
import '../cubits/local_articles/local_articles_cubit.dart';
import '../widgets/article.dart';

class SavedArticlesView extends HookWidget {
  const SavedArticlesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.pop(),
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
        title: const Text(
          'Saved Articles',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<LocalArticlesCubit, LocalArticlesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case LocalArticlesLoading:
              return const Center(child: CupertinoActivityIndicator());
            case LocalArticlesSuccess:
              return SavedArticles(articles: state.articles);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class SavedArticles extends StatelessWidget {
  final List<Article> articles;
  const SavedArticles({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const Center(
          child: Text(
            'NO SAVED ARTICLES',
            style: TextStyle(color: Colors.black),
          ));
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleWidget(
          article: articles[index],
          isRemovable: true,
          onRemove: (article) => BlocProvider.of<LocalArticlesCubit>(context)
              .removeArticle(article: article),
          onArticlePressed: (article) => (),
        );
      },
    );
  }
}
