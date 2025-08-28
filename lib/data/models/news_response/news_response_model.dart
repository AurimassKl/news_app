import 'package:json_annotation/json_annotation.dart';
import 'package:newsapp/data/models/news_article/news_article_model.dart';

part 'news_response_model.g.dart';

@JsonSerializable()
class NewsResponseModel {
  final String status;
  final int? totalResults;
  final List<NewsArticleModel>? articles;
  final String? code;
  final String? message;

  const NewsResponseModel({
    required this.status,
    this.totalResults,
    this.articles,
    this.code,
    this.message,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) => _$NewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseModelToJson(this);
}
