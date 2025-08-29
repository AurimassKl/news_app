import 'package:json_annotation/json_annotation.dart';
import 'package:newsapp/data/models/news_source/news_source_model.dart';

part 'news_source_response_model.g.dart';

@JsonSerializable()
class NewsSourceResponseModel {
  final String status;
  final List<NewsSourceModel> sources;

  const NewsSourceResponseModel({
    required this.status,
    required this.sources,
  });

  factory NewsSourceResponseModel.fromJson(Map<String, dynamic> json) => _$NewsSourceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceResponseModelToJson(this);
}
