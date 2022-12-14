// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      id: json['_id'] as String,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      totalAmount: json['totalAmount'],
      quantity: json['quantity'] as int?,
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      shippingCost: json['shippingCost'] as num?,
      orderStatus:
          OrderStatus.fromJson(json['orderStatus'] as Map<String, dynamic>),
      paymentType: json['paymentType'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'address': instance.address,
      'totalAmount': instance.totalAmount,
      'quantity': instance.quantity,
      'items': instance.items,
      'shippingCost': instance.shippingCost,
      'orderStatus': instance.orderStatus,
      'paymentType': instance.paymentType,
      'paymentStatus': instance.paymentStatus,
      'createdAt': instance.createdAt,
    };
