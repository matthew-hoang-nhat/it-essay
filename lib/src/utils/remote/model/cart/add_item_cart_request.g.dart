// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_item_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddItemCartRequest _$AddItemCartRequestFromJson(Map<String, dynamic> json) =>
    AddItemCartRequest(
      userId: json['userId'] as String?,
      cartItems: (json['cartItems'] as List<dynamic>?)
          ?.map((e) => ItemCartRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      cartItem: json['cartItem'] == null
          ? null
          : ItemCartRequest.fromJson(json['cartItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddItemCartRequestToJson(AddItemCartRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'cartItems': instance.cartItems,
      'cartItem': instance.cartItem,
    };
