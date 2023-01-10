// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'm_notification.g.dart';

@JsonSerializable()
class MNotification {
  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'status')
  bool status;
  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'type')
  Map<String, String> typeObject;

  MNotification({
    required this.title,
    required this.id,
    required this.content,
    required this.status,
    required this.createdAt,
    required this.typeObject,
  });

  factory MNotification.fromJson(Map<String, dynamic> json) =>
      _$MNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$MNotificationToJson(this);

  MNotification copyWith({
    String? title,
    String? content,
    bool? status,
    String? createdAt,
    String? id,
    Map<String, String>? typeObject,
  }) {
    return MNotification(
      title: title ?? this.title,
      content: content ?? this.content,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      typeObject: typeObject ?? this.typeObject,
      id: id ?? this.id,
    );
  }
}
