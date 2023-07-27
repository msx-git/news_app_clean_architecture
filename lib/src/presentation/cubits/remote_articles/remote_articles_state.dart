part of 'remote_articles_cubit.dart';

abstract class RemoteArticlesState extends Equatable {
  final List<Article> articles;
  final bool noMoreData;
  ///the property “noMoreData” is used to indicate that there’s no more articles to be loaded,
  /// so that the UI can know and stop displaying progress indicator
  /// at the bottom of the scrolling widget
  final DioException? dioException;

  const RemoteArticlesState({
    this.articles = const [],
    this.noMoreData = true,
    this.dioException,
  });

  @override
  List<Object?> get props => [articles, noMoreData, dioException];
}

class RemoteArticlesLoading extends RemoteArticlesState {
  const RemoteArticlesLoading();

  @override
  List<Object> get props => [];
}

class RemoteArticlesSuccess extends RemoteArticlesState{

  const RemoteArticlesSuccess({super.articles,super.noMoreData});
}

class RemoteArticlesFailed extends RemoteArticlesState{

  const RemoteArticlesFailed({super.dioException});
}
