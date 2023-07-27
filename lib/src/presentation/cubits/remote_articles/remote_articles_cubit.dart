import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:news_app/src/domain/models/requests/breaking_news_request.dart';
import 'package:news_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:news_app/src/utils/constants/numbers.dart';
import 'package:news_app/src/utils/resources/data_state.dart';

import '../../../domain/models/article.dart';
import '../../../domain/repositories/api_repository.dart';

part 'remote_articles_state.dart';

class RemoteArticlesCubit
    extends BaseCubit<RemoteArticlesState, List<Article>> {
  final ApiRepository _apiRepository;

  RemoteArticlesCubit(this._apiRepository)
      : super(const RemoteArticlesLoading(), []);

  int _page = 1;

  Future<void> getBreakingNewsArticles() async {
    if (isBusy) return;
    await run(() async {
      final response = await _apiRepository.getBreakingNewsArticles(
        request: BreakingNewsRequest(page: _page),
      );

      if (response is DataSuccess) {
        final articles = response.data!.articles;
        final noMoreData = articles.length < kDefaultPageSize;

        data.add(articles as Article);
        _page++;

        emit(RemoteArticlesSuccess(articles: data, noMoreData: noMoreData));
      } else if (response is DataFailed) {
        emit(RemoteArticlesFailed(dioException: response.dioException));
      }
    });
  }
}
