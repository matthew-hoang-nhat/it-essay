// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'comment_review.g.dart';

@JsonSerializable()
class CommentReview {
  @JsonKey(name: 'rating')
  double ratingNumber;

  @JsonKey(name: 'posted')
  String dateTime;

  @JsonKey(name: 'text')
  String text;
  @JsonKey(name: 'file')
  List<Map<String, String>>? attaches;

  CommentReview({
    required this.ratingNumber,
    this.dateTime = '',
    required this.text,
    this.attaches,
  });

  factory CommentReview.fromJson(Map<String, dynamic> json) =>
      _$CommentReviewFromJson(json);

  Map<String, dynamic> toJson() => _$CommentReviewToJson(this);
}
