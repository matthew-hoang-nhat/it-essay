import 'package:it_project/src/features/main/home_product/repositories/product_repository.dart';
import 'package:it_project/src/features/main/home_product/services/models/category.dart';
import 'package:it_project/src/features/main/home_product/services/models/product.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl({
    required super.productService,
  });

  @override
  Future<List<Product>> getProducts() async {
    final dataResponse = await productService.getProducts();
    final List<dynamic> dataItems = dataResponse.data;
    List<Product> products = List.generate(dataItems.length,
        (index) => Product.fromJson(dataItems.elementAt(index)));
    return products;
  }

  @override
  Future<List<Category>> getCategories() async {
    final dataResponse = await productService.getCategories();
    final List<dynamic> dataItems = dataResponse.data;
    List<Category> products = List.generate(dataItems.length,
        (index) => Category.fromJson(dataItems.elementAt(index)));
    return products;
  }
}
