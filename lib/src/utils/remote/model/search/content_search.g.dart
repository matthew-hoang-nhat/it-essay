// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentSearch _$ContentSearchFromJson(Map<String, dynamic> json) =>
    ContentSearch(
      id: json['_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ContentSearchToJson(ContentSearch instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'type': instance.type,
    };
