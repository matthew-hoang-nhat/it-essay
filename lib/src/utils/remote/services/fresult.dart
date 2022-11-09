import 'package:dio/dio.dart';

class FResult<T> {
  T? data;
  String? error;
  bool get isError => error != null;
  bool get isSuccess => error == null && data != null;
  FResult.success(this.data) {
    error = null;
  }

  FResult.error(String? error) {
    data = null;
    this.error = error ?? 'An Unknown Error Occurred';
  }

  FResult.exception(Object? e) {
    data = null;
    if (e is DioError) {
      error = e.message;
      return;
    }

    error ??= 'An Unknown Error Occurred';
  }
}
