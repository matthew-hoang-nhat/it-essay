// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderNotification _$OrderNotificationFromJson(Map<String, dynamic> json) =>
    OrderNotification(
      content: json['content'] as String,
      typeObject: Map<String, String>.from(json['type'] as Map),
    );

Map<String, dynamic> _$OrderNotificationToJson(OrderNotification instance) =>
    <String, dynamic>{
      'content': instance.content,
      'type': instance.typeObject,
    };
