import 'package:json_annotation/json_annotation.dart';

part 'item_add_order_request.g.dart';

@JsonSerializable()
class ItemOrderRequest {
  @JsonKey(name: 'productId')
  String productId;
  @JsonKey(name: 'quantity')
  int quantity;
  @JsonKey(name: 'shippingCode')
  int shippingCode;
  ItemOrderRequest({
    required this.productId,
    required this.quantity,
    this.shippingCode = 1,
  });

  factory ItemOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$ItemOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ItemOrderRequestToJson(this);
}
