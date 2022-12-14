import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/model/order/add/add_order_request.dart';
import 'package:it_project/src/utils/remote/model/order/get/item_order.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/remote/model/order/get/order_response.dart';
import 'package:it_project/src/utils/repository/order_repository.dart';
import 'package:logger/logger.dart';

class OrderRepositoryImpl extends OrderRepository {
  OrderRepositoryImpl({required super.orderService});

  final limitLNumber = 10;

  @override
  Future<FResult<List<ItemOrder>>> getAllCompletedOrders(
      {required int currentPage}) async {
    try {
      final result =
          await orderService.getAllCompletedOrders(currentPage, limitLNumber);
      final itemOrder =
          (result.data as List).map((e) => ItemOrder.fromJson(e)).toList();

      return FResult.success(itemOrder);
    } catch (ex) {
      // if (ex is DioError) {
      //   Logger().e(ex.response?.data);
      // } else {
      //   Logger().e(ex.toString());
      // }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<List<OrderResponse>>> getAllOrder(
      {required int currentPage}) async {
    try {
      final result = await orderService.getAllOrder(currentPage, limitLNumber);
      final orderResponses = (result.data['orders'] as List)
          .map((e) => OrderResponse.fromJson(e))
          .toList();
      return FResult.success(orderResponses);
    } catch (ex) {
      // if (ex is DioError) {
      //   Logger().e(ex.response?.data);
      // } else {
      //   Logger().e(ex.toString());
      // }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<List<ItemOrder>>> getAllOrdered(
      {required int currentPage}) async {
    try {
      final result =
          await orderService.getAllOrdered(currentPage, limitLNumber);
      final itemOrder =
          (result.data as List).map((e) => ItemOrder.fromJson(e)).toList();

      return FResult.success(itemOrder);
    } catch (ex) {
      // if (ex is DioError) {
      //   Logger().e(ex.response?.data);
      // } else {
      //   Logger().e(ex.toString());
      // }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<List<ItemOrder>>> getAllShippingOrders(
      {required int currentPage}) async {
    try {
      final result =
          await orderService.getAllShippingOrders(currentPage, limitLNumber);
      final itemOrder =
          (result.data as List).map((e) => ItemOrder.fromJson(e)).toList();

      return FResult.success(itemOrder);
    } catch (ex) {
      // if (ex is DioError) {
      //   Logger().e(ex.response?.data);
      // } else {
      //   Logger().e(ex.toString());
      // }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<OrderResponse>> getDetailOrder(
      {required String orderId}) async {
    try {
      final orderRequest = {'orderId': orderId};

      final orderResponse = await orderService.getDetailOrder(orderRequest);

      return FResult.success(
          OrderResponse.fromJson(orderResponse.data['order']));
    } catch (ex) {
      if (ex is DioError) {
        Logger().e(ex.response?.data);
      } else {
        Logger().e(ex);
      }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<List<ItemOrder>>> getAllCancelOrders(
      {required int currentPage}) async {
    try {
      final result =
          await orderService.getAllCancelOrders(currentPage, limitLNumber);
      final itemOrder =
          (result.data as List).map((e) => ItemOrder.fromJson(e)).toList();
      return FResult.success(itemOrder);
    } catch (ex) {
      // if (ex is DioError) {
      //   Logger().e(ex.response?.data);
      // } else {
      //   Logger().e(ex.toString());
      // }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<List<ItemOrder>>> getAllPacked(
      {required int currentPage}) async {
    try {
      final result = await orderService.getAllPacked(currentPage, limitLNumber);
      final itemOrder =
          (result.data as List).map((e) => ItemOrder.fromJson(e)).toList();

      return FResult.success(itemOrder);
    } catch (ex) {
      // if (ex is DioError) {
      //   Logger().e(ex.response?.data);
      // } else {
      //   Logger().e(ex.toString());
      // }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<Map<String, dynamic>>> createOrder(
      {required AddOrderRequest addOrderRequest}) async {
    try {
      final orderRequest = {'order': addOrderRequest};
      final result = await orderService.addOrder(orderRequest);

      return FResult.success(result.data);
    } catch (ex) {
      // if (ex is DioError) {
      //   Logger().e(ex.response?.data);
      // } else {
      //   Logger().e(ex.toString());
      // }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<String>> cancelAnItemOrder(
      {required String itemOrderId}) async {
    try {
      final cancelRequest = {'orderItemId': itemOrderId};
      final result = await orderService.cancelAnItemOrder(cancelRequest);
      return FResult.success('Bạn đã hủy thành công');
    } catch (ex) {
      // if (ex is DioError) {
      //   Logger().e(ex.response?.data);
      // } else {
      //   Logger().e(ex.toString());
      // }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<String>> cancelOrder({required String orderId}) async {
    try {
      final cancelRequest = {'orderId': orderId};
      final result = await orderService.cancelOrder(cancelRequest);
      return FResult.success('Bạn đã hủy thành công');
    } catch (ex) {
      // if (ex is DioError) {
      //   Logger().e(ex.response?.data);
      // } else {
      //   Logger().e(ex.toString());
      // }
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<String>> checkStatusOrder({required String paymentId}) async {
    try {
      final checkStatusOrderRequest = {'payId': paymentId};
      final result =
          await orderService.checkStatusOrder(checkStatusOrderRequest);

      return FResult.success(result.data['paymentStatus']);
    } catch (ex) {
      if (ex is DioError) {
        Logger().e(ex.response?.data);
      } else {
        Logger().e(ex.toString());
      }
      return FResult.error(ex.toString());
    }
  }
}
