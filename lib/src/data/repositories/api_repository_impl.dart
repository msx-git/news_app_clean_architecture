import 'package:news_app/src/data/datasources/remote/news_api_service.dart';
import 'package:news_app/src/domain/models/requests/breaking_news_request.dart';
import 'package:news_app/src/domain/models/responses/breaking_news_response.dart';
import 'package:news_app/src/utils/resources/data_state.dart';

import '../../domain/repositories/api_repository.dart';
import '../base/base_api_repository.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final NewsApiService _newsApiService;

  ApiRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<BreakingNewsResponse>> getBreakingNewsArticles(
      {required BreakingNewsRequest request}) {
    return getStateOf<BreakingNewsResponse>(
      request: () => _newsApiService.getBreakingNewsArticles(
        apiKey: request.apiKey,
        country: request.country,
        category: request.category,
        page: request.page,
        pageSize: request.pageSize,
      ),
    );
  }
}