import 'package:hive/hive.dart';

part 'item_cart.g.dart';

@HiveType(typeId: 0)
class ItemCart extends HiveObject {
  @HiveField(0)
  final String slug;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int quantity;

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

  ItemCart(
    {required  this.price,
    required this.slug,
    required this.name,
    required this.quantity,
    required this.sellerName,
    required this.discountPercent,
    required this.mainCategory,
    required this.productImage,
  });
}
