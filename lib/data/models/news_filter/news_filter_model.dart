import 'package:json_annotation/json_annotation.dart';

part 'news_filter_model.g.dart';

@JsonSerializable(includeIfNull: false)
class NewsFilterModel {
  final String? country;
  final String? category;
  final String? sources;
  final String? query;

  const NewsFilterModel({
    this.country,
    this.category,
    this.sources,
    this.query,
  });

  factory NewsFilterModel.fromJson(Map<String, dynamic> json) => _$NewsFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsFilterModelToJson(this);
}
