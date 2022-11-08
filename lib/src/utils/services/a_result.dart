// import 'package:dio/dio.dart';

// class AResult<T> {
//   T? data;
//   String? error;
//   bool get isError => error != null;
//   bool get isSuccess => error == null && data != null;
//   AResult.success(this.data) {
//     error = null;
//   }

//   AResult.error(String? error) {
//     data = null;
//     this.error = error ?? 'An Unknown Error Occurred';
//   }

//   AResult.exception(Object? e) {
//     data = null;
//     if (e is DioError) {
//       error = e.message;
//       return;
//     }

//     error ??= 'An Unknown Error Occurred';
//   }
// }
