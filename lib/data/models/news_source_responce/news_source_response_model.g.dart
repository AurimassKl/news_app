// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_source_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsSourceResponseModel _$NewsSourceResponseModelFromJson(
        Map<String, dynamic> json) =>
    NewsSourceResponseModel(
      status: json['status'] as String,
      totalResults: (json['totalResults'] as num?)?.toInt(),
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => NewsSourceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NewsSourceResponseModelToJson(
        NewsSourceResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'sources': instance.sources,
      'code': instance.code,
      'message': instance.message,
    };
