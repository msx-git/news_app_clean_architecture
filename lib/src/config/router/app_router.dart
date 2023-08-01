import 'package:go_router/go_router.dart';
import 'package:news_app/src/config/router/routes.dart';
import 'package:news_app/src/presentation/views/breaking_news_view.dart';
import 'package:news_app/src/presentation/views/saved_articles_views.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'Breaking News View',
      path: Routes.breakingNews,
      builder: (context, state) => const BreakingNewsView(),
    ),
    // GoRoute(
    //   name: 'Article Details View',
    //   path: Routes.articleDetails,
    //   builder: (context, state) => const ArticleDetailsView(article: null),
    // ),
    GoRoute(
      name: 'Saved Articles View',
      path: Routes.savedArticles,
      builder: (context, state) => const SavedArticlesView(),
    ),
  ],
);
