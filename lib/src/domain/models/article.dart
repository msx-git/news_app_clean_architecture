import 'package:equatable/equatable.dart';
import 'source.dart';

class Article extends Equatable {
  final int? id;
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const Article({
    this.id,
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as int,
      source: map['source'] as Source,
      author: map['author'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      url: map['url'] as String,
      urlToImage: map['urlToImage'] as String,
      publishedAt: map['publishedAt'] as String,
      content: map['content'] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];

  @override
  String toString() {
    return 'Article{id: $id, source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content}';
  }
}
