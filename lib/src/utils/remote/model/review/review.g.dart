// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['discuss_id'] as int,
      user: json['user'] as Map<String, dynamic>?,
      page: json['page'] as int,
      ratingNumber: (json['rating'] as num).toDouble(),
      dateTime: json['posted'] as String?,
      text: json['text'] as String,
      attaches: (json['file'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'discuss_id': instance.id,
      'user': instance.user,
      'page': instance.page,
      'rating': instance.ratingNumber,
      'posted': instance.dateTime,
      'text': instance.text,
      'file': instance.attaches,
    };
