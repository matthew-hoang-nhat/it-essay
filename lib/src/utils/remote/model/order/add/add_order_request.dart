import 'package:json_annotation/json_annotation.dart';

import 'item_add_order_request.dart';

part 'add_order_request.g.dart';

@JsonSerializable()
class AddOrderRequest {
  @JsonKey(name: 'addressId')
  String addressId;

  @JsonKey(name: 'paymentType')
  String paymentType;

  @JsonKey(name: 'items')
  List<ItemOrderRequest> items;
  AddOrderRequest({
    required this.addressId,
    this.paymentType = 'cod',
    required this.items,
  });

  factory AddOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$AddOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddOrderRequestToJson(this);
}
