// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _SellerService implements SellerService {
  _SellerService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SuccessResponse> getCategoriesOfSeller({required sellerId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'sellerId': sellerId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SuccessResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/seller/categories',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SuccessResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SuccessResponse> getInfoSeller({required sellerId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'sellerId': sellerId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SuccessResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/seller/info',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SuccessResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SuccessResponse> getProductsOfCategory(
      {required sellerId,
      categoryId,
      required limit,
      required currentPage}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sellerId': sellerId,
      r'categoryId': categoryId,
      r'limit': limit,
      r'currentPage': currentPage
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SuccessResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/seller',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SuccessResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
