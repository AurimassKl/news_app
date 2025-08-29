// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsFilterModel _$NewsFilterModelFromJson(Map<String, dynamic> json) =>
    NewsFilterModel(
      country: json['country'] as String?,
      category: json['category'] as String?,
      sources: json['sources'] as String?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$NewsFilterModelToJson(NewsFilterModel instance) =>
    <String, dynamic>{
      if (instance.country case final value?) 'country': value,
      if (instance.category case final value?) 'category': value,
      if (instance.sources case final value?) 'sources': value,
      if (instance.query case final value?) 'query': value,
    };
