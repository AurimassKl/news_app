// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_source_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsSourceFilterModel _$NewsSourceFilterModelFromJson(
        Map<String, dynamic> json) =>
    NewsSourceFilterModel(
      category: json['category'] as String,
      language: json['language'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$NewsSourceFilterModelToJson(
        NewsSourceFilterModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'language': instance.language,
      'country': instance.country,
    };
