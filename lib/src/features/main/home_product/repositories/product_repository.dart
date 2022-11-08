import 'package:it_project/src/features/main/home_product/services/models/category.dart';
import 'package:it_project/src/features/main/home_product/services/models/product.dart';
import 'package:it_project/src/features/main/home_product/services/product_service.dart';

abstract class ProductRepository {
  final ProductService productService;

  ProductRepository({required this.productService});

  Future<List<Product>> getProducts();
  Future<List<Category>> getCategories();
}
