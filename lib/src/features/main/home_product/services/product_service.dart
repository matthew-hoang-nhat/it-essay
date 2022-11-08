import 'package:dio/dio.dart';
import 'package:it_project/src/utils/services/state_response/success_response.dart';

import 'package:retrofit/retrofit.dart';

part 'product_service.g.dart';

@RestApi()
abstract class ProductService {
  factory ProductService(Dio dio, {String baseUrl}) = _ProductService;

  @GET("/products")
  Future<SuccessResponse> getProducts();

  @GET("/categories")
  Future<SuccessResponse> getCategories();
}
