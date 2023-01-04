// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCartRequest _$ItemCartRequestFromJson(Map<String, dynamic> json) =>
    ItemCartRequest(
      product: json['product'],
      quantity: json['quantity'] as int?,
      wishlist: json['wishlist'] as bool?,
    );

Map<String, dynamic> _$ItemCartRequestToJson(ItemCartRequest instance) =>
    <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
      'wishlist': instance.wishlist,
    };
