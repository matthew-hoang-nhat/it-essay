import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/remote/model/order/get/province.dart';
import 'package:it_project/src/utils/repository/location_repository.dart';

class LocationRepositoryImpl extends LocationRepository {
  LocationRepositoryImpl({required super.locationService});

  @override
  Future<FResult<List<Province>>> getProvinces() async {
    // try {
    final provinces = await locationService.getProvinces(3);
    return FResult.success(provinces);
    // } catch (ex) {
    //   Logger().e(ex.toString());
    //   return FResult.error(ex.toString());
    // }
  }
}
