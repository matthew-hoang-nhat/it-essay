// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemOrder _$ItemOrderFromJson(Map<String, dynamic> json) => ItemOrder(
      discount: json['discount'] as int?,
      orderStatus: json['orderStatus'],
      price: json['price'],
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      paymentType: json['paymentType'] as String?,
      orderId: json['orderId'] as String?,
      isCancel: json['isCancel'] as bool? ?? false,
      id: json['_id'] as String?,
      quantity: json['quantity'] as int?,
      shippingCost: json['shippingCost'],
      totalPaid: json['totalPaid'],
      seller: json['seller'] != null
          ? ProfileSeller.fromJson(json['seller'] as Map<String, dynamic>)
          : null,
    );

Map<String, dynamic> _$ItemOrderToJson(ItemOrder instance) => <String, dynamic>{
      '_id': instance.id,
      'product': instance.product,
      'discount': instance.discount,
      'isCancel': instance.isCancel,
      'price': instance.price,
      'totalPaid': instance.totalPaid,
      'quantity': instance.quantity,
      'shippingCost': instance.shippingCost,
      'orderId': instance.orderId,
      'orderStatus': instance.orderStatus,
      'paymentType': instance.paymentType,
      'seller': instance.seller,
    };
