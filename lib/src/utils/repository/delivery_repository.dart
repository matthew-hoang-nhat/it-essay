import 'package:it_project/src/utils/remote/model/order/get/address.dart';
import 'package:it_project/src/utils/remote/services/delivery/delivery_service.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';

abstract class DeliveryRepository {
  final DeliveryService deliveryService;

  DeliveryRepository({required this.deliveryService});
  Future<FResult<bool>> addAddress({required Address address});
  Future<FResult<List<Address>>> getAddresses();
  Future<FResult<bool>> deleteAddress({required String addressId});
  Future<FResult<bool>> updateAddress({required Address address});
  Future<FResult<bool>> setDefaultAddress({required String addressId});
}
