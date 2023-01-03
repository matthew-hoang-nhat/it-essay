// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentReview _$CommentReviewFromJson(Map<String, dynamic> json) =>
    CommentReview(
      ratingNumber: (json['rating'] as num).toDouble(),
      dateTime: json['posted'] as String? ?? '',
      text: json['text'] as String,
      attaches: (json['file'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$CommentReviewToJson(CommentReview instance) =>
    <String, dynamic>{
      'rating': instance.ratingNumber,
      'posted': instance.dateTime,
      'text': instance.text,
      'file': instance.attaches,
    };
