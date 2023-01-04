import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/model/review/review.dart';
import 'package:it_project/src/utils/remote/model/review/review_request.dart';
import 'package:it_project/src/utils/remote/services/state_response/success_response.dart';

import 'package:retrofit/retrofit.dart';

part 'review_service.g.dart';

@RestApi()
abstract class ReviewService {
  factory ReviewService(Dio dio, {String baseUrl}) = _ReviewService;

  @POST("/review/add")
  Future<SuccessResponse> addReview({
    @Body() required ReviewRequest review,
  });
  @PUT("/review/update")
  Future<SuccessResponse> updateReview({
    @Body() required Review review,
  });
  @DELETE("/review/delete")
  Future<SuccessResponse> deleteReview(
      {@Body() required Map<String, dynamic> deleteReviewRequest});
  @GET("/review/get")
  Future<SuccessResponse> getReviews({
    @Query("productId") required String productId,
    @Query("page") required int page,
  });
  @POST("/review/check-permission")
  Future<SuccessResponse> checkPermission(
      {@Body() required Map<String, String> orderIdObject});
}
