import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/presentation/views/article_details_view.dart';

import '../../domain/models/article.dart';
import 'article.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({
    required this.scrollController,
    required this.articles,
    required this.noMoreData,
    super.key,
  });

  final ScrollController scrollController;
  final List<Article> articles;
  final bool noMoreData;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: articles.length,
            (context, index) => ArticleWidget(
              article: articles[index],
              onArticlePressed: (a) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ArticleDetailsView(article: articles[index]),
                ),
              ),
            ),
          ),
        ),
        if (!noMoreData)
          const SliverToBoxAdapter(child: CupertinoActivityIndicator()),
      ],
    );
  }
}
