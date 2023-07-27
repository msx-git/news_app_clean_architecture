import 'package:dio/dio.dart';
import 'package:news_app/src/domain/models/responses/breaking_news_response.dart';
import 'package:retrofit/retrofit.dart';
import '../../../utils/constants/strings.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl, parser: Parser.MapSerializable)
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<BreakingNewsResponse>> getBreakingNewsArticles({
    @Query('apiKey') String? apiKey,
    @Query('country') String? country,
    @Query('category') String? category,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });
}
