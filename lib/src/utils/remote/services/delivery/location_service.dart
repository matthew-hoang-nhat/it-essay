import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/model/order/get/province.dart';

import 'package:retrofit/retrofit.dart';

part 'location_service.g.dart';

@RestApi()
abstract class LocationService {
  factory LocationService(Dio dio, {String baseUrl}) = _LocationService;

  @GET("/")
  Future<List<Province>> getProvinces(@Query('depth') int depth);
}
