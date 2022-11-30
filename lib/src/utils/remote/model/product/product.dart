import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/spec.dart';
import 'package:it_project/src/utils/remote/model/seller/profile_seller.dart';

import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'price')
  int price;
  @JsonKey(name: 'discountPercent')
  int discountPercent;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'slug')
  String slug;
  @JsonKey(name: 'seller')
  ProfileSeller? seller;
  @JsonKey(name: 'category')
  Category category;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'summary')
  String? summary;
  @JsonKey(name: 'productPictures')
  dynamic productImages;
  @JsonKey(name: 'specs')
  Spec spec;

  Product(
      {this.discountPercent = 0,
      required this.category,
      required this.slug,
      required this.id,
      required this.price,
      required this.productImages,
      required this.name,
      required this.spec,
      required this.description,
      required this.summary,
      required this.seller});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
