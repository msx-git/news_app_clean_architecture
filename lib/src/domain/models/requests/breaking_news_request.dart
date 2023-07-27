import 'package:news_app/src/utils/constants/numbers.dart';
import 'package:news_app/src/utils/constants/strings.dart';

class BreakingNewsRequest{
  final String apiKey;
  final String country;
  final String category;
  final int page;
  final int pageSize;

  BreakingNewsRequest({
    this.apiKey = kApiKey,
    this.country = 'us',
    this.category = 'general',
    this.page = 1,
    this.pageSize = kDefaultPageSize,
});

}