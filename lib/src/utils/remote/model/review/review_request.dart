// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'comment_review.dart';

part 'review_request.g.dart';

@JsonSerializable()
class ReviewRequest {
  @JsonKey(name: 'productId')
  String? productId;

  @JsonKey(name: 'discuss_id')
  int id;
  @JsonKey(name: 'user')
  Map<String, dynamic>? user;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'comment')
  CommentReview comment;

  ReviewRequest({
    this.productId,
    this.id = 0,
    this.user,
    required this.page,
    required this.comment,
  });

  factory ReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewRequestToJson(this);
}
