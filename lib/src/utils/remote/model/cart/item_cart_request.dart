import 'package:json_annotation/json_annotation.dart';
part 'item_cart_request.g.dart';

@JsonSerializable()
class ItemCartRequest {
  @JsonKey(name: 'product')
  dynamic product;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'wishlist')
  bool? wishlist;

  ItemCartRequest({
    required this.product,
    this.quantity,
    this.wishlist,
  });

  factory ItemCartRequest.fromJson(Map<String, dynamic> json) =>
      _$ItemCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCartRequestToJson(this);
}
