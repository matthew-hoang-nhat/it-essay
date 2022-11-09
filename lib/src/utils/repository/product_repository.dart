import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/remote/services/product/product_service.dart';

abstract class ProductRepository {
  final ProductService productService;

  ProductRepository({required this.productService});

  Future<FResult< List<Product>>> getProducts();

  Future<FResult<List<Category>>> getCategories();
  Future<FResult<Product?>> getDetailProduct(String slug);
}
