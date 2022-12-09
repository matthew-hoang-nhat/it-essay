import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/services/state_response/success_response.dart';

import 'package:retrofit/retrofit.dart';

part 'order_service.g.dart';

@RestApi()
abstract class OrderService {
  factory OrderService(Dio dio, {String baseUrl}) = _OrderService;

  @POST("/order/add")
  Future<SuccessResponse> addOrder(
      @Body() Map<String, dynamic> addOrderRequest);

  @POST("/pay/check-status")
  Future<SuccessResponse> checkStatusOrder(
      @Body() Map<String, dynamic> checkStatusOrderRequest);

  @POST("/order/get-detail")
  Future<SuccessResponse> getDetailOrder(
      @Body() Map<String, String> orderRequest);

  @GET("/order/all")
  Future<SuccessResponse> getAllOrder(
    @Query('currentPage') int currentPage,
    @Query('limit') int limit,
  );

  @GET("/order/all-ordered")
  Future<SuccessResponse> getAllOrdered(
    @Query('currentPage') int currentPage,
    @Query('limit') int limit,
  );

  @GET("/order/all-orders-packed")
  Future<SuccessResponse> getAllPacked(
    @Query('currentPage') int currentPage,
    @Query('limit') int limit,
  );

  @GET("/order/all-orders-completed")
  Future<SuccessResponse> getAllCompletedOrders(
    @Query('currentPage') int currentPage,
    @Query('limit') int limit,
  );

  @GET("/order/get-all-orders-cancel")
  Future<SuccessResponse> getAllCancelOrders(
    @Query('currentPage') int currentPage,
    @Query('limit') int limit,
  );

  @GET("/order/all-orders-shipping")
  Future<SuccessResponse> getAllShippingOrders(
    @Query('currentPage') int currentPage,
    @Query('limit') int limit,
  );

  @POST("/order/cancel-order-item")
  Future<SuccessResponse> cancelAnItemOrder(
      @Body() Map<String, String> cancelRequest);
  @POST("/order/cancel-order")
  Future<SuccessResponse> cancelOrder(
      @Body() Map<String, String> cancelRequest);
}
