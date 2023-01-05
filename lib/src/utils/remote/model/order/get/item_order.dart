import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/seller/profile_seller.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_order.g.dart';

@JsonSerializable()
class ItemOrder {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'product')
  Product product;

  @JsonKey(name: 'discount')
  int? discount;

  @JsonKey(name: 'isCancel')
  bool? isCancel;

  @JsonKey(name: 'price')
  dynamic? price;

  @JsonKey(name: 'totalPaid')
  dynamic? totalPaid;

  @JsonKey(name: 'quantity')
  int? quantity;

  @JsonKey(name: 'shippingCost')
  dynamic? shippingCost;

  @JsonKey(name: 'orderId')
  String? orderId;

  @JsonKey(name: 'orderStatus')
  dynamic orderStatus;
  @JsonKey(name: 'paymentType')
  String? paymentType;

  @JsonKey(name: 'seller')
  ProfileSeller? seller;

  ItemOrder(
      {required this.discount,
      required this.orderStatus,
      required this.price,
      required this.product,
      required this.paymentType,
      required this.orderId,
      this.isCancel = false,
      required this.id,
      required this.quantity,
      required this.shippingCost,
      required this.totalPaid,
      this.seller});

  factory ItemOrder.fromJson(Map<String, dynamic> json) =>
      _$ItemOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ItemOrderToJson(this);
}
