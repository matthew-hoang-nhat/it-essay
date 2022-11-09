import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/seller.dart';
import 'package:it_project/src/utils/remote/model/product/spec.dart';

import 'package:json_annotation/json_annotation.dart';

import 'product_picture.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'price')
  int price;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'seller')
  Seller? seller;
  @JsonKey(name: 'category')
  Category category;
  @JsonKey(name: 'productPictures')
  List<ProductPicture> productImages;
  @JsonKey(name: 'specs')
  Spec spec;

  Product(
      {required this.category,
      required this.id,
      required this.price,
      required this.productImages,
      required this.name,
      required this.spec,
      required this.seller});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
