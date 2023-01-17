import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/services/f_result.dart';
import 'package:it_project/src/utils/remote/model/order/get/address.dart';
import 'package:it_project/src/utils/repository/delivery_repository.dart';
import 'package:logger/logger.dart';

class DeliveryRepositoryImpl extends DeliveryRepository {
  DeliveryRepositoryImpl({required super.deliveryService});

  @override
  Future<FResult<bool>> addAddress({required Address address}) async {
    try {
      await deliveryService.addAddress({'address': address});
      return FResult.success(true);
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
  Future<FResult<bool>> deleteAddress({required String addressId}) async {
    try {
      await deliveryService.deleteAddress(
        {'addressId': addressId},
      );
      return FResult.success(true);
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
  Future<FResult<List<Address>>> getAddresses() async {
    try {
      final addressesResponse = await deliveryService.getAddresses();
      final items = (addressesResponse.data['address'] as List);
      return FResult.success(items.map((e) => Address.fromJson(e)).toList());
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
  Future<FResult<bool>> setDefaultAddress({required String addressId}) async {
    try {
      await deliveryService.setDefaultAddress({"addressId": addressId});
      return FResult.success(true);
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
  Future<FResult<bool>> updateAddress({required Address address}) async {
    try {
      await deliveryService.updateAddress({
        "addressId": address.id!,
        "address": address,
      });
      return FResult.success(true);
    } catch (ex) {
      if (ex is DioError) {
        Logger().e(ex.response?.data);
      } else {
        Logger().e(ex);
      }
      return FResult.error(ex.toString());
    }
  }
}
