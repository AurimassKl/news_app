import 'package:json_annotation/json_annotation.dart';

part 'news_source_filter_model.g.dart';

@JsonSerializable()
class NewsSourceFilterModel {
  final String? category;
  final String? language;
  final String? country;

  const NewsSourceFilterModel({
    this.category,
    this.language,
    this.country,
  });

  factory NewsSourceFilterModel.fromJson(Map<String, dynamic> json) => _$NewsSourceFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceFilterModelToJson(this);
}
