// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spec _$SpecFromJson(Map<String, dynamic> json) => Spec(
      author: json['author'] as String,
      publisher: json['publisher'] as String,
      city: json['city'] as String,
      publicationDate: json['publicationDate'] as String,
    );

Map<String, dynamic> _$SpecToJson(Spec instance) => <String, dynamic>{
      'author': instance.author,
      'publisher': instance.publisher,
      'city': instance.city,
      'publicationDate': instance.publicationDate,
    };
