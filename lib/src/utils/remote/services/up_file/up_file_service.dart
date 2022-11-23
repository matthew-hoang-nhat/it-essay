import 'dart:io';

import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

part 'up_file_service.g.dart';

@RestApi()
abstract class UpFileService {
  factory UpFileService(Dio dio, {String baseUrl}) = _UpFileService;

  @POST("/api/upload-image")
  @MultiPart()
  Future<Map<String, String>> uploadFile({
    @Part(name: 'file') required File attach,
  });
}
