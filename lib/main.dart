import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/config/router/app_router.dart';
import 'package:news_app/src/config/theme/app_themes.dart';
import 'package:news_app/src/domain/repositories/api_repository.dart';
import 'package:news_app/src/locator.dart';
import 'package:news_app/src/presentation/cubits/remote_articles/remote_articles_cubit.dart';
import 'package:oktoast/oktoast.dart';

import 'src/domain/repositories/database_repository.dart';
import 'src/presentation/cubits/local_articles/local_articles_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RemoteArticlesCubit(
            locator<ApiRepository>(),
          )..getBreakingNewsArticles(),
        ),
        BlocProvider(
          create: (context) => LocalArticlesCubit(
            locator<DatabaseRepository>(),
          )..getAllSavedArticles(),
        ),
      ],
      child: OKToast(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: AppTheme.light,
        ),
      ),
    );
  }
}
