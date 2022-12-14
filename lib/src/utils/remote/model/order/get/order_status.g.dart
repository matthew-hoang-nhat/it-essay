// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatus _$OrderStatusFromJson(Map<String, dynamic> json) => OrderStatus(
      type: json['type'] as String,
      date: json['date'] as String,
      isCompleted: json['isCompleted'] as bool,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$OrderStatusToJson(OrderStatus instance) =>
    <String, dynamic>{
      'type': instance.type,
      'date': instance.date,
      'isCompleted': instance.isCompleted,
      '_id': instance.id,
    };
