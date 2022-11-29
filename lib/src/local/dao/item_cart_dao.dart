// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'item_cart_dao.g.dart';

@HiveType(typeId: 0)
class ItemCart extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  final String sellerName;

  @HiveField(4)
  final int discountPercent;

  @HiveField(5)
  final String mainCategory;

  @HiveField(6)
  final String productImage;
  @HiveField(7)
  final int price;

  ItemCart({
    required this.price,
    required this.id,
    required this.name,
    required this.quantity,
    required this.sellerName,
    required this.discountPercent,
    required this.mainCategory,
    required this.productImage,
  });

  ItemCart copyWith({
    String? slug,
    String? name,
    int? quantity,
    String? sellerName,
    int? discountPercent,
    String? mainCategory,
    String? productImage,
    int? price,
  }) {
    return ItemCart(
      id: slug ?? id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      sellerName: sellerName ?? this.sellerName,
      discountPercent: discountPercent ?? this.discountPercent,
      mainCategory: mainCategory ?? this.mainCategory,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
    );
  }
}
