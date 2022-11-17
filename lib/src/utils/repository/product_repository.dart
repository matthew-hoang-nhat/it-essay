import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/remote/services/product/product_service.dart';

abstract class ProductRepository {
  final ProductService productService;

  ProductRepository({required this.productService});

  Future<FResult<List<Product>>> getProducts(
      {required int numberPage, String? name});

  Future<FResult<List<Product>>> getFlashSaleProducts(
      {required int numberPage, String? name});

  Future<FResult<List<Product>>> getProductsOfCategoryPage(
      {required String categorySlug, required int numberPage});
  // Future<FResult<List<Product>>> getProductsOfSeller(
  //     {required String sellerId, required int numberPage});
  Future<FResult<Product?>> getDetailProduct(String slug);
}
