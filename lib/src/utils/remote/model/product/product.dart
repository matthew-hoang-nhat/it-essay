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
  int? price;
  @JsonKey(name: 'discountPercent')
  int discountPercent;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'seller')
  ProfileSeller? seller;
  @JsonKey(name: 'category')
  Category? category;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'summary')
  String? summary;
  @JsonKey(name: 'productPictures')
  dynamic productImages;
  @JsonKey(name: 'specs')
  Spec? spec;

  Product(
      {this.discountPercent = 0,
      this.category,
      this.slug,
      this.quantity = 0,
      required this.id,
      this.price,
      this.productImages,
      required this.name,
      this.spec,
      this.description = '',
      this.summary = '',
      this.seller});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
