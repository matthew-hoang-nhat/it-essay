import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/services/state_response/success_response.dart';

import 'package:retrofit/retrofit.dart';

part 'category_service.g.dart';

@RestApi()
abstract class CategoryService {
  factory CategoryService(Dio dio, {String baseUrl}) = _CategoryService;

  @GET("/categories")
  Future<SuccessResponse> getCategoriesPage({
    @Query("limit") int? limit,
    @Query("currentPage") int? currentPage,
  });
}
