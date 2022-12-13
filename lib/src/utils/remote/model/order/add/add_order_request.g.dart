// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOrderRequest _$AddOrderRequestFromJson(Map<String, dynamic> json) =>
    AddOrderRequest(
      addressId: json['addressId'] as String,
      paymentType: json['paymentType'] as String? ?? 'cod',
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemOrderRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddOrderRequestToJson(AddOrderRequest instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'paymentType': instance.paymentType,
      'items': instance.items,
    };
