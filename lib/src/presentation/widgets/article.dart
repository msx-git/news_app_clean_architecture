import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../domain/models/article.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;
  final bool isRemovable;
  final void Function(Article article)? onRemove;
  final void Function(Article article)? onArticlePressed;

  const ArticleWidget({
    Key? key,
    required this.article,
    this.onArticlePressed,
    this.isRemovable = false,
    this.onRemove,
  }) : super(key: key);

  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed?.call(article);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 7),
        height: MediaQuery.sizeOf(context).width / 2.2,
        child: Row(
          children: [
            ArticleImage(context: context, article: article),
            ArticleTitleAndDescription(article: article),
            ArticleRemoveButton(
              article: article,
              isRemovable: isRemovable,
              onRemove: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleImage extends StatelessWidget {
  const ArticleImage({super.key, required this.context, required this.article});

  final BuildContext context;
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
          ),
          child: Image.network(
            article.urlToImage ?? '',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return const Center(
                child: Text(
                  '404\nNOT FOUND',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ArticleTitleAndDescription extends StatelessWidget {
  const ArticleTitleAndDescription({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              article.title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            // Description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(article.description ?? '', maxLines: 2),
              ),
            ),

            // Datetime
            Row(
              children: [
                const Icon(Ionicons.time_outline, size: 16),
                const SizedBox(width: 4),
                Text(
                  article.publishedAt ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleRemoveButton extends StatelessWidget {
  const ArticleRemoveButton(
      {super.key,
      required this.article,
      required this.isRemovable,
      this.onRemove});

  final Article article;
  final bool isRemovable;
  final void Function(Article article)? onRemove;

  @override
  Widget build(BuildContext context) {
    if (isRemovable) {
      return GestureDetector(
        onTap: _onRemove,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Ionicons.trash_outline, color: Colors.red),
        ),
      );
    }
    return Container();
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove?.call(article);
    }
  }
}
