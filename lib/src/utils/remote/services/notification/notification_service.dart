import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/services/state_response/success_response.dart';

import 'package:retrofit/retrofit.dart';

part 'notification_service.g.dart';

@RestApi()
abstract class NotificationService {
  factory NotificationService(Dio dio, {String baseUrl}) = _NotificationService;

  @GET("/notification/get")
  Future<SuccessResponse> getNotifications({
    @Query('limit') required int limit,
    @Query('currentPage') required int currentPage,
  });
  @PUT("/notification/update-read")
  Future<SuccessResponse> updateNotifications(
      {@Body() required Map<String, dynamic> updateNotificationRequest});
}
