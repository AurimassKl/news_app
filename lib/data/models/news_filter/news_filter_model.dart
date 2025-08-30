import 'package:json_annotation/json_annotation.dart';

part 'news_filter_model.g.dart';

@JsonSerializable(includeIfNull: false)
class NewsFilterModel {
  final String? country;
  final String? category;
  final String? sources;
  final String? q;
  final int? page;
  final int? pageSize;

  const NewsFilterModel({
    this.country,
    this.category,
    this.sources,
    this.q,
    this.page,
    this.pageSize,
  });

  factory NewsFilterModel.fromJson(Map<String, dynamic> json) => _$NewsFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsFilterModelToJson(this);
}
