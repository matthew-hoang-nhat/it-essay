import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl({
    required super.productService,
  });
  final limitSProduct = 5;
  final limitLProduct = 10;

  @override
  Future<FResult<List<Product>>> getProducts(
      {required int numberPage, String? name}) async {
    try {
      final dataResponse = await productService.getProductsPage(
          currentPage: numberPage, limit: limitSProduct, name: name);
      final List<dynamic> dataItems = dataResponse.data;
      List<Product> products = List.generate(dataItems.length,
          (index) => Product.fromJson(dataItems.elementAt(index)));
      return FResult.success(products);
    } catch (ex) {
      if (ex is DioError) {
        log('getProducts: ${ex.error}');
      }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<Product>> getDetailProduct(String slug) async {
    try {
      final dataResponse = await productService.getDetailProduct(slug);
      final product = Product.fromJson(dataResponse.data);
      return FResult.success(product);
    } catch (ex) {
      if (ex is DioError) {
        log('getDetailProduct: ${ex.error}');
      }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<List<Product>>> getProductsOfCategoryPage(
      {required String categorySlug, required int numberPage}) async {
    try {
      final dataResponse = await productService.getProductsOfCategoryPage(
          currentPage: 0, limit: limitSProduct, slug: categorySlug);
      final List<dynamic> dataItems = dataResponse.data;
      List<Product> products = List.generate(dataItems.length,
          (index) => Product.fromJson(dataItems.elementAt(index)));
      return FResult.success(products);
    } catch (ex) {
      if (ex is DioError) {
        log('getProductsOfCategoryPage: ${ex.error}');
      }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<List<Product>>> getProductsOfSeller(
      {required String sellerId, required int numberPage}) async {
    try {
      final dataResponse = await productService.getProductsPage(
          currentPage: 0, limit: limitSProduct, sellerId: sellerId);
      final List<dynamic> dataItems = dataResponse.data;
      List<Product> products = List.generate(dataItems.length,
          (index) => Product.fromJson(dataItems.elementAt(index)));
      return FResult.success(products);
    } catch (ex) {
      if (ex is DioError) {
        log('getProductsOfSeller: ${ex.error}');
      }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<List<Product>>> getFlashSaleProducts(
      {required int numberPage, String? name}) async {
    try {
      final dataResponse = await productService.getProductsPage(
          currentPage: numberPage, limit: limitLProduct, name: name);
      final List<dynamic> dataItems = dataResponse.data;
      List<Product> products = List.generate(dataItems.length,
          (index) => Product.fromJson(dataItems.elementAt(index)));
      return FResult.success(products);
    } catch (ex) {
      if (ex is DioError) {
        log('getProducts: ${ex.error}');
      }
      return FResult.error(ex.toString());
    }
  }
}
