// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:it_project/src/utils/remote/model/cart/item_cart_request.dart';
part 'add_item_cart_request.g.dart';

@JsonSerializable()
class AddItemCartRequest {
  @JsonKey(name: 'userId')
  String? userId;

  @JsonKey(name: 'cartItems')
  List<ItemCartRequest>? cartItems;

  @JsonKey(name: 'cartItem')
  ItemCartRequest? cartItem;

  AddItemCartRequest({
    this.userId,
    this.cartItems,
    this.cartItem,
  });

  factory AddItemCartRequest.fromJson(Map<String, dynamic> json) =>
      _$AddItemCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddItemCartRequestToJson(this);
}
