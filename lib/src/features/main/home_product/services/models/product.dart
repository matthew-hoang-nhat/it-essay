import 'package:it_project/src/features/main/home_product/services/models/category.dart';
import 'package:it_project/src/features/main/home_product/services/models/product_picture.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'price')
  int price;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'category')
  Category category;
  @JsonKey(name: 'productPictures')
  List<ProductPicture> productImages;

  Product(
      {required this.category,
      required this.id,
      required this.price,
      required this.productImages,
      required this.name});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
