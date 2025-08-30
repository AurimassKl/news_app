import 'package:json_annotation/json_annotation.dart';
import 'package:newsapp/data/models/news_source/news_source_model.dart';

part 'news_source_response_model.g.dart';

@JsonSerializable()
class NewsSourceResponseModel {
  final String status;
  final int? totalResults;
  final List<NewsSourceModel>? sources;
  final String? code;
  final String? message;

  const NewsSourceResponseModel({
    required this.status,
    this.totalResults,
    this.sources,
    this.code,
    this.message,
  });

  factory NewsSourceResponseModel.fromJson(Map<String, dynamic> json) => _$NewsSourceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceResponseModelToJson(this);
}
