import 'package:it_project/src/utils/remote/services/f_result.dart';
import 'package:it_project/src/utils/remote/model/order_notification/m_notification.dart';
import 'package:it_project/src/utils/repository/notification_repository.dart';
import 'package:logger/logger.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  NotificationRepositoryImpl(super.notificationService);
  final limitS = 10;
  @override
  Future<FResult<List<MNotification>>> getNotifications(
      {required int currentPage}) async {
    try {
      // final response = SuccessResponse.fromJson(_response);
      final response = await notificationService.getNotifications(
          limit: limitS, currentPage: currentPage);
      final items = response.data as List;

      if (items.isNotEmpty) {
        return FResult.success(
            items.map((e) => MNotification.fromJson(e)).toList());
      }
      return FResult.error('Hết trang ');
    } catch (ex) {
      Logger().e(ex);
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<String>> updateNotification(
      {required String notificationId, required bool status}) async {
    try {
      final updateNotificationRequest = {
        "notificationId": notificationId,
        "status": status
      };
      await notificationService.updateNotifications(
          updateNotificationRequest: updateNotificationRequest);

      return FResult.success('Cập nhật notification thành công');
    } catch (ex) {
      Logger().e(ex);
      return FResult.error(ex.toString());
    }
  }
}

// final _response = {
//   "data": [
//     {
//       "_id": "63ae88c9be4ae0698028646f",
//       "user": "636bd01075089b78a0b5b6d7",
//       "content": "The seller confirmed your order",
//       "title": "The order confirmation",
//       "status": false,
//       "type": {"type": "order", "orderId": "63ae88c0be4ae0698028645f"},
//       "specs": [],
//       "createdAt": "2022-12-30T06:44:25.451Z",
//       "updatedAt": "2022-12-30T06:44:25.451Z",
//       "__v": 0
//     },
//     {
//       "_id": "63ae88a49b2f0e76d54892c6",
//       "user": "636bd01075089b78a0b5b6d7",
//       "content": "The seller confirmed your order",
//       "title": "The order confirmation",
//       "status": true,
//       "type": {"type": "order", "orderId": "63ae88879b2f0e76d54892af"},
//       "specs": [],
//       "createdAt": "2022-12-30T06:43:48.325Z",
//       "updatedAt": "2022-12-30T06:43:48.325Z",
//       "__v": 0
//     },
//     {
//       "_id": "63ad697a84517d713c1bdd83",
//       "user": "636bd01075089b78a0b5b6d7",
//       "content": "The shipper confirmed your order",
//       "title": "The order confirmation",
//       "status": false,
//       "type": {"type": "delivery", "orderId": "63906e369b990aeec7b3fbad"},
//       "specs": [],
//       "createdAt": "2022-12-29T10:18:34.376Z",
//       "updatedAt": "2022-12-29T10:18:34.376Z",
//       "__v": 0
//     },
//     {
//       "_id": "63ad64daed39d2d44d7ab21e",
//       "user": "636bd01075089b78a0b5b6d7",
//       "content": "The shipper confirmed your order",
//       "title": "The order confirmation",
//       "status": true,
//       "type": {"type": "delivery", "orderId": "63906ebc9b990aeec7b3fbc8"},
//       "specs": [],
//       "createdAt": "2022-12-29T09:58:50.649Z",
//       "updatedAt": "2022-12-29T09:58:50.649Z",
//       "__v": 0
//     },
//     {
//       "_id": "63ad64d7ed39d2d44d7ab213",
//       "user": "636bd01075089b78a0b5b6d7",
//       "content": "The shipper confirmed your order",
//       "title": "The order confirmation",
//       "status": true,
//       "type": {"type": "delivery", "orderId": "63906ec88e8daeba21593a5f"},
//       "specs": [],
//       "createdAt": "2022-12-29T09:58:47.975Z",
//       "updatedAt": "2022-12-29T09:58:47.975Z",
//       "__v": 0
//     },
//     {
//       "_id": "63ad62a0b8b88a92d0b4de48",
//       "user": "636bd01075089b78a0b5b6d7",
//       "content": "The shipper confirmed your order",
//       "title": "The order confirmation",
//       "status": false,
//       "type": {"type": "delivery", "orderId": "6397e26c186d26c4a0320635"},
//       "specs": [],
//       "createdAt": "2022-12-29T09:49:20.184Z",
//       "updatedAt": "2022-12-29T09:49:20.184Z",
//       "__v": 0
//     },
//     {
//       "_id": "63ad454498be958a1b86ecad",
//       "user": "636bd01075089b78a0b5b6d7",
//       "content": "The seller confirmed your order",
//       "title": "The order confirmation",
//       "status": false,
//       "type": {"type": "order", "orderId": "63ad453849d98c3c0b122342"},
//       "specs": [],
//       "createdAt": "2022-12-29T07:44:04.667Z",
//       "updatedAt": "2022-12-29T07:44:04.667Z",
//       "__v": 0
//     },
//     {
//       "_id": "63ad450a98be958a1b86ec9a",
//       "user": "636bd01075089b78a0b5b6d7",
//       "content": "The seller confirmed your order",
//       "title": "The order confirmation",
//       "status": false,
//       "type": {"type": "order", "orderId": "63ad450398be958a1b86ec8a"},
//       "specs": [],
//       "createdAt": "2022-12-29T07:43:06.926Z",
//       "updatedAt": "2022-12-29T07:43:06.926Z",
//       "__v": 0
//     },
//     {
//       "_id": "63ad3e6898be958a1b86ec2c",
//       "user": "636bd01075089b78a0b5b6d7",
//       "content": "The shipper confirmed your order",
//       "title": "The order confirmation",
//       "status": false,
//       "type": {"type": "delivery", "orderId": "63a16d0846c4f23eb7159c02"},
//       "specs": [],
//       "createdAt": "2022-12-29T07:14:48.784Z",
//       "updatedAt": "2022-12-29T07:14:48.784Z",
//       "__v": 0
//     },
//     {
//       "_id": "63ad3bbd02831f16f0f5f7d6",
//       "user": "636bd01075089b78a0b5b6d7",
//       "content": "The seller confirmed your order",
//       "title": "The order confirmation",
//       "status": false,
//       "type": {"type": "order", "orderId": "63ad3baa02831f16f0f5f7c5"},
//       "specs": [],
//       "createdAt": "2022-12-29T07:03:25.283Z",
//       "updatedAt": "2022-12-29T07:03:25.283Z",
//       "__v": 0
//     }
//   ]
// };
