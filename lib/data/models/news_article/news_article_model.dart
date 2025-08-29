import 'package:json_annotation/json_annotation.dart';
import 'package:newsapp/domain/entities/news_article.dart';

part 'news_article_model.g.dart';

@JsonSerializable()
class NewsArticleModel {
  final SourceModel source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  const NewsArticleModel({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) => _$NewsArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticleModelToJson(this);

  NewsArticle toEntity() => NewsArticle(
        title: title,
        description: description ?? "",
        url: url,
        urlToImage: urlToImage ?? "",
        publishedAt: publishedAt,
        sourceName: source.name,
        sourceId: source.id ?? "",
        content: content ?? "",
        author: author ?? "",
      );
}

@JsonSerializable()
class SourceModel {
  final String? id;
  final String name;

  const SourceModel({
    this.id,
    required this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) => _$SourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}
