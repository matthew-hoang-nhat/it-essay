// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:it_project/src/utils/remote/model/order/get/item_order.dart';

import 'address.dart';
import 'order_status.dart';

part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'address')
  Address? address;

  @JsonKey(name: 'totalAmount')
  dynamic totalAmount;

  @JsonKey(name: 'quantity')
  int? quantity;

  @JsonKey(name: 'items')
  List<ItemOrder> items;

  @JsonKey(name: 'shippingCost')
  num? shippingCost;

  @JsonKey(name: 'orderStatus')
  OrderStatus orderStatus;

  @JsonKey(name: 'paymentType')
  String? paymentType;

  @JsonKey(name: 'paymentStatus')
  String? paymentStatus;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  OrderResponse({
    required this.id,
    this.address,
    required this.totalAmount,
    required this.quantity,
    required this.items,
    this.shippingCost,
    required this.orderStatus,
    this.paymentType,
    this.paymentStatus,
    this.createdAt,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
