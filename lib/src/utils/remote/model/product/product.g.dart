// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      discountPercent: json['discountPercent'] as int? ?? 0,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      slug: json['slug'] as String?,
      quantity: json['quantity'] as int? ?? 0,
      id: json['_id'] as String,
      price: json['price'] as int?,
      productImages: json['productPictures'],
      name: json['name'] as String,
      spec: json['specs'] == null
          ? null
          : Spec.fromJson(json['specs'] as Map<String, dynamic>),
      description: json['description'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      seller: json['seller'] == null
          ? null
          : ProfileSeller.fromJson(json['seller'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'price': instance.price,
      'discountPercent': instance.discountPercent,
      'name': instance.name,
      'slug': instance.slug,
      'quantity': instance.quantity,
      'seller': instance.seller,
      'category': instance.category,
      'description': instance.description,
      'summary': instance.summary,
      'productPictures': instance.productImages,
      'specs': instance.spec,
    };
