import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fuser_local.dart';

const String keyAccept = 'Accept';
const String keyAuth = 'Authorization';

class DioHttpClient extends DioForNative {
  DioHttpClient(
    String baseUrl, {
    BaseOptions? options,
  }) : super(options) {
    interceptors.add(InterceptorsWrapper(onRequest: _requestInterceptor));

    this.options.baseUrl = baseUrl;
  }

  void _requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey(keyAuth)) {
      options.headers.remove(keyAuth);
    }
    String? tokenValue = getIt<FUserLocal>().acceptToken;

    if (tokenValue != null) {
      options.headers[keyAuth] = 'Bearer $tokenValue';
    }

    // options.headers[keyAccept] = 'application/json';

    options.connectTimeout = 20000;
    options.receiveTimeout = 20000;

    // options.extra['withCredentials'] = true;

    handler.next(options);
  }
}
