import 'package:equatable/equatable.dart';

import '../article.dart';

class BreakingNewsResponse extends Equatable {
  final String status;
  final int totalResult;
  final List<Article> articles;

  const BreakingNewsResponse({
    required this.status,
    required this.totalResult,
    required this.articles,
  });

  factory BreakingNewsResponse.fromMap(Map<String, dynamic> map) {
    return BreakingNewsResponse(
      status: map['status'] as String,
      totalResult: map['totalResult'] as int,
      articles: map['articles'] as List<Article>,
    );
  }

  @override
  List<Object> get props => [status, totalResult, articles];

  @override
  String toString() {
    return 'BreakingNewsResponse{status: $status, totalResult: $totalResult, articles: $articles}';
  }
}