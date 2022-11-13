import 'package:json_annotation/json_annotation.dart';
part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  @JsonKey(name: 'product')
  dynamic slug;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'wishlist')
  bool? wishlist;

  CartItem({
    required this.slug,
    required this.quantity,
    required this.wishlist,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
