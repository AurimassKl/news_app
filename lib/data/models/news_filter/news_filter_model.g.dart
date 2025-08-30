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
      q: json['q'] as String?,
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NewsFilterModelToJson(NewsFilterModel instance) =>
    <String, dynamic>{
      if (instance.country case final value?) 'country': value,
      if (instance.category case final value?) 'category': value,
      if (instance.sources case final value?) 'sources': value,
      if (instance.q case final value?) 'q': value,
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
    };
