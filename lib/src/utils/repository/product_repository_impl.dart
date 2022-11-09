import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl({
    required super.productService,
  });

  @override
  Future<FResult<List<Product>>> getProducts() async {
    try {
      final dataResponse = await productService.getProducts();
      final List<dynamic> dataItems = dataResponse.data;
      List<Product> products = List.generate(dataItems.length,
          (index) => Product.fromJson(dataItems.elementAt(index)));
      return FResult.success(products);
    } catch (ex) {
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
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<List<Category>>> getCategories() async {
    try {
      final dataResponse = await productService.getCategories();
      final List<dynamic> dataItems = dataResponse.data;
      List<Category> categories = List.generate(dataItems.length,
          (index) => Category.fromJson(dataItems.elementAt(index)));
      return FResult.success(categories);
    } catch (ex) {
      return FResult.error(ex.toString());
    }
  }
}
