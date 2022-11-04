import '../services/remote/response/state_response/error_response.dart';

class CatchErrorResponse {
  static String? errorToString(dioError) {
    ErrorResponse errResponse = ErrorResponse.fromJson(dioError.response?.data);

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
