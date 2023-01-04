// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewRequest _$ReviewRequestFromJson(Map<String, dynamic> json) =>
    ReviewRequest(
      productId: json['productId'] as String?,
      id: json['discuss_id'] as int? ?? 0,
      user: json['user'] as Map<String, dynamic>?,
      page: json['page'] as int,
      comment: CommentReview.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewRequestToJson(ReviewRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'discuss_id': instance.id,
      'user': instance.user,
      'page': instance.page,
      'comment': instance.comment,
    };
