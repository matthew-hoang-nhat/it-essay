import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/services/state_response/success_response.dart';

import 'package:retrofit/retrofit.dart';

part 'seller_service.g.dart';

@RestApi()
abstract class SellerService {
  factory SellerService(Dio dio, {String baseUrl}) = _SellerService;

  @GET("/seller/categories")
  Future<SuccessResponse> getCategoriesOfSeller({
    @Query("sellerId") String? sellerId,
  });

  @GET("/seller/info")
  Future<SuccessResponse> getInfoSeller(
    @Query("sellerId") String? sellerId,
  );

  @GET("/seller")
  Future<SuccessResponse> getProductsOfCategory({
    @Query("sellerId") String? sellerId,
    @Query("categoryId") String? categoryId,
    @Query("limit") required int limit,
    @Query("currentPage") required int currentPage,
  });
}
