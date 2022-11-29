import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/model/seller/profile_seller.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/repository/seller_repository.dart';

class SellerRepositoryImpl extends SellerRepository {
  SellerRepositoryImpl({
    required super.sellerService,
  });

  final sizeSLimit = 5;
  @override
  Future<FResult<List<Category>>> getCategories(
      {required String sellerId}) async {
    try {
      final response =
          await sellerService.getCategoriesOfSeller(sellerId: sellerId);
      final List<dynamic> items = response.data;

      return FResult.success(
          items.map((item) => Category.fromJson(item['category'])).toList());
    } catch (ex) {
      if (ex is DioError) {
        log('getCategories: ${ex.error}');
      }
      log('getCategories: ${ex.toString()}');
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<ProfileSeller>> getInfo({required String sellerId}) async {
    // try {
    final response = await sellerService.getInfoSeller(sellerId: sellerId);
    final profileSeller = ProfileSeller.fromJson(response.data);

    return FResult.success(profileSeller);
    // } catch (ex) {
    //   if (ex is DioError) {
    //     log('getInfo: ${ex.error}');
    //   }
    //   log('getInfo: ${ex.toString()}');
    //   return FResult.error(ex.toString());
    // }
  }

  @override
  Future<FResult<List<Product>>> getProducts({
    required String sellerId,
    required int currentPage,
    String? categoryId,
    int? limit,
  }) async {
    try {
      final response = await sellerService.getProductsOfCategory(
          sellerId: sellerId,
          currentPage: currentPage,
          limit: limit ?? sizeSLimit,
          categoryId: categoryId);

      final List<dynamic> items = response.data['products'];
      final int totalItem = response.data['totalProducts'];

      if (totalItem < sizeSLimit * (currentPage - 1)) {
        throw Exception('Over length page products');
      }
      return FResult.success(items.map((e) => Product.fromJson(e)).toList());
    } catch (ex) {
      if (ex is DioError) {
        log('getProducts: ${ex.error}');
      }
      log('getProducts: ${ex.toString()}');
      return FResult.error(ex.toString());
    }
  }
}
