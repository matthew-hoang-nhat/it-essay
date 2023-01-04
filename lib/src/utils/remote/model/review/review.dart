// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  // @JsonKey(name: '_id')
  // String id;
  @JsonKey(name: 'discuss_id')
  int id;
  @JsonKey(name: 'user')
  Map<String, dynamic>? user;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'rating')
  double ratingNumber;

  @JsonKey(name: 'posted')
  String? dateTime;

  @JsonKey(name: 'text')
  String text;
  @JsonKey(name: 'file')
  List<Map<String, String>>? attaches;

  Review({
    required this.id,
    this.user,
    required this.page,
    required this.ratingNumber,
    this.dateTime,
    required this.text,
    this.attaches,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
