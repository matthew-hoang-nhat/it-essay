// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MNotification _$MNotificationFromJson(Map<String, dynamic> json) =>
    MNotification(
      title: json['title'] as String,
      id: json['_id'] as String,
      content: json['content'] as String,
      status: json['status'] as bool,
      createdAt: json['createdAt'] as String,
      typeObject: Map<String, String>.from(json['type'] as Map),
    );

Map<String, dynamic> _$MNotificationToJson(MNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      '_id': instance.id,
      'content': instance.content,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'type': instance.typeObject,
    };
