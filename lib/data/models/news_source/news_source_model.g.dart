// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_source_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsSourceModel _$NewsSourceModelFromJson(Map<String, dynamic> json) =>
    NewsSourceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      category: json['category'] as String,
      language: json['language'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$NewsSourceModelToJson(NewsSourceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'category': instance.category,
      'language': instance.language,
      'country': instance.country,
    };
