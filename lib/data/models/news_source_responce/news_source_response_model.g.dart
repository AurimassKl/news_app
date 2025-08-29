// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_source_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsSourceResponseModel _$NewsSourceResponseModelFromJson(
        Map<String, dynamic> json) =>
    NewsSourceResponseModel(
      status: json['status'] as String,
      sources: (json['sources'] as List<dynamic>)
          .map((e) => NewsSourceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsSourceResponseModelToJson(
        NewsSourceResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'sources': instance.sources,
    };
