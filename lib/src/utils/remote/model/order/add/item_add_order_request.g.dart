// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_add_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemOrderRequest _$ItemOrderRequestFromJson(Map<String, dynamic> json) =>
    ItemOrderRequest(
      productId: json['productId'] as String,
      quantity: json['quantity'] as int,
      shippingCode: json['shippingCode'] as int? ?? 1,
    );

Map<String, dynamic> _$ItemOrderRequestToJson(ItemOrderRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'shippingCode': instance.shippingCode,
    };
