import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:oktoast/oktoast.dart';

import '../../config/router/app_router.dart';
import '../../domain/models/article.dart';
import '../cubits/local_articles/local_articles_cubit.dart';

class ArticleDetailsView extends HookWidget {
  final Article? article;

  const ArticleDetailsView({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localArticlesCubit = BlocProvider.of<LocalArticlesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: ()=> context.pop(),
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Article Title and Date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article?.title ?? '',
                    style: const TextStyle(
                      fontFamily: 'Butler',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(Ionicons.time_outline, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        article?.publishedAt ?? '',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Article Image
            Container(
              width: double.maxFinite,
              height: 250,
              margin: const EdgeInsets.only(top: 14),
              child: Image.network(
                article?.urlToImage ?? '',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            /// Article Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              child: Text(
                '${article?.description}\n\n${article?.content}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          localArticlesCubit.saveArticle(article: article!);
          showToast('Article Saved Successfully');
        },
        child: const Icon(Ionicons.bookmark, color: Colors.white),
      ),
    );
  }
}
