import 'package:it_project/src/utils/remote/model/order/get/province.dart';
import 'package:it_project/src/utils/remote/services/delivery/location_service.dart';
import 'package:it_project/src/utils/remote/services/f_result.dart';

abstract class LocationRepository {
  final LocationService locationService;
  LocationRepository({required this.locationService});

  Future<FResult<List<Province>>> getProvinces();
}
