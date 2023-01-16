import 'package:it_project/src/utils/remote/model/order/add/add_order_request.dart';
import 'package:it_project/src/utils/remote/model/order/get/item_order.dart';
import 'package:it_project/src/utils/remote/model/order/get/order_response.dart';
import 'package:it_project/src/utils/remote/services/f_result.dart';
import 'package:it_project/src/utils/remote/services/order/order_service.dart';

abstract class OrderRepository {
  final OrderService orderService;
  OrderRepository({required this.orderService});

  Future<FResult<Map<String, dynamic>>> createOrder(
      {required AddOrderRequest addOrderRequest});
  Future<FResult<String>> checkStatusOrder({required String paymentId});

  Future<FResult<OrderResponse>> getDetailOrder({required String orderId});
  Future<FResult<List<OrderResponse>>> getAllOrder({required int currentPage});
  Future<FResult<List<ItemOrder>>> getAllOrdered({required int currentPage});
  Future<FResult<List<ItemOrder>>> getAllPacked({required int currentPage});
  Future<FResult<List<ItemOrder>>> getAllShippingOrders(
      {required int currentPage});
  Future<FResult<List<ItemOrder>>> getAllCompletedOrders(
      {required int currentPage});
  Future<FResult<List<ItemOrder>>> getAllCancelOrders(
      {required int currentPage});

  Future<FResult<String>> cancelOrder({required String orderId});
  Future<FResult<String>> cancelAnItemOrder({required String itemOrderId});
}
