part of '../../core/login_register/repositories/auth_repository.dart';

// extension StringX on String {
//   String get toPrice {
//     final oCcy = NumberFormat("#,##", "en_US");
//     return oCcy.format(this);
//   }
// }

extension DioErrorX on DioError {
  String? errorsToString() {
    ErrorResponse errResponse = ErrorResponse.fromJson(response?.data);

    if (errResponse.error['message'] is String) {
      return errResponse.error['message'];
    }
    if (errResponse.error['message'] is List<String>) {
      String err = '';
      for (var item in errResponse.error['message']) {
        err += item;
      }
      return err;
    }
    return null;
  }
}
