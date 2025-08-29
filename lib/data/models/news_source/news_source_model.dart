import 'package:json_annotation/json_annotation.dart';
import 'package:newsapp/domain/entities/news_sources.dart';

part 'news_source_model.g.dart';

@JsonSerializable()
class NewsSourceModel {
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;

  const NewsSourceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  factory NewsSourceModel.fromJson(Map<String, dynamic> json) => _$NewsSourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceModelToJson(this);

  NewsSource toEntity() => NewsSource(
        id: id,
        name: name,
        description: description,
        url: url,
        category: category,
        language: language,
        country: country,
      );
}
