import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/services/state_response/success_response.dart';

import 'package:retrofit/retrofit.dart';

part 'delivery_service.g.dart';

@RestApi()
abstract class DeliveryService {
  factory DeliveryService(Dio dio, {String baseUrl}) = _DeliveryService;

  @POST("/delivery/add")
  Future<SuccessResponse> addAddress(
      @Body() Map<String, dynamic> addressRequest);

  @GET("/delivery/get")
  Future<SuccessResponse> getAddresses();

  @POST("/delivery/delete")
  Future<SuccessResponse> deleteAddress(
      @Body() Map<String, String> itemAddress);

  @PUT("/delivery/update")
  Future<SuccessResponse> updateAddress(
      @Body() Map<String, dynamic> updateAddress);

  @PUT("/delivery/set-default")
  Future<SuccessResponse> setDefaultAddress(
      @Body() Map<String, String> defaultAddress);
}
