import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/utils/repository/auth_repository_impl.dart';

const String keyAccept = 'Accept';
const String keyAuth = 'Authorization';

class DioHttpClient extends DioForNative {
  DioHttpClient(
    String baseUrl, {
    BaseOptions? options,
  }) : super(options) {
    interceptors.add(InterceptorsWrapper(
        onRequest: _requestInterceptor, onError: _errorInterceptor));
    this.options.baseUrl = baseUrl;
  }

  final fUserLocal = getIt<FUserLocal>();
  Future<void> _errorInterceptor(
      DioError err, ErrorInterceptorHandler handler) async {
    final authRepo = getIt<AuthRepositoryImpl>();

    if (err.response?.statusCode == 409) {
      final currentRefreshToken = fUserLocal.refreshToken;
      fUserLocal.fUser =
          fUserLocal.fUser?.copyWith(accessToken: currentRefreshToken);
      final result = await authRepo.refreshToken();
      if (result.isSuccess) {
        final newAcceptToken = result.data?['access_token'];
        final newRefreshToken = result.data?['refreshToken'];
        fUserLocal.fUser = fUserLocal.fUser?.copyWith(
            accessToken: newAcceptToken, refreshToken: newRefreshToken);
      }
    }
    handler.next(err);
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
