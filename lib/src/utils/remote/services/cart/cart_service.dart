import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/services/state_response/success_response.dart';

import 'package:retrofit/retrofit.dart';

part 'cart_service.g.dart';

@RestApi()
abstract class CartService {
  factory CartService(Dio dio, {String baseUrl}) = _CartService;

  @GET("/cart/get-cart-items")
  Future<SuccessResponse> getItemsInCart();

  @GET("/cart/add-to-cart")
  Future<SuccessResponse> addItemInCart();

  // @POST("/cart/remove-item")
  // Future<SuccessResponse> removeItemInCart(@Body() CartItem cartItem);

  // @POST("/cart/add-multiple-items")
  // Future<SuccessResponse> addMultiItemsInCart(@Body() CartItem cartItem);
}
