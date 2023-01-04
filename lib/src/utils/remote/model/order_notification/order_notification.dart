// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'order_notification.g.dart';

@JsonSerializable()
class OrderNotification {
  // @JsonKey(name: 'title')
  // String title;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'type')
  Map<String, String> typeObject;

  OrderNotification({
    // required this.title,
    required this.content,
    required this.typeObject,
  });

  factory OrderNotification.fromJson(Map<String, dynamic> json) =>
      _$OrderNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$OrderNotificationToJson(this);
}
