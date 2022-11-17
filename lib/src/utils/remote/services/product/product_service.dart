import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/services/state_response/success_response.dart';

import 'package:retrofit/retrofit.dart';

part 'product_service.g.dart';

@RestApi()
abstract class ProductService {
  factory ProductService(Dio dio, {String baseUrl}) = _ProductService;

  @GET("/products")
  Future<SuccessResponse> getProductsPage({
    @Query("name") String? name,
    @Query("limit") required int limit,
    @Query("currentPage") required int currentPage,
  });

  @GET("/product/{slug}")
  Future<SuccessResponse> getDetailProduct(@Path('slug') String slug);
  @GET("/category")
  Future<SuccessResponse> getProductsOfCategoryPage({
    @Query('slug') required String slug,
    @Query('limit') required int limit,
    @Query('currentPage') required int currentPage,
  });

  @GET("/categories")
  Future<SuccessResponse> getCategories();

  @GET("/categories")
  Future<SuccessResponse> getCategoriesPage({
    @Query("limit") required int limit,
    @Query("currentPage") required int currentPage,
  });
}
