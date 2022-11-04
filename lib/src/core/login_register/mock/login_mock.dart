import 'package:it_project/src/utils/services/remote/response/state_response/error_response.dart';

class LoginMock {
  ErrorResponse invalidFormat = ErrorResponse(error: [
    'Email is not valid',
  ]);
}
