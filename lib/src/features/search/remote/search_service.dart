import 'package:dio/dio.dart';

import 'package:it_project/src/utils/services/state_response/success_response.dart';

import 'package:retrofit/retrofit.dart';

part 'search_service.g.dart';

@RestApi()
abstract class SearchService {
  factory SearchService(Dio dio, {String baseUrl}) = _SearchService;

  @GET("/search")
  Future<SuccessResponse> searchContent(@Query("keyword") String contentSearch);
}
