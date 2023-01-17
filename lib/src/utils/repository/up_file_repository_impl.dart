import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:it_project/src/utils/remote/services/f_result.dart';
import 'package:it_project/src/utils/repository/up_file_repository.dart';
import 'package:logger/logger.dart';

class UpFileRepositoryImpl extends UpFileRepository {
  UpFileRepositoryImpl({required super.upFileService});

  @override
  Future<FResult<String>> uploadFile(XFile file) async {
    try {
      final response = await upFileService.uploadFile(attach: File(file.path));
      return FResult.success(response['fileLink']);
    } catch (ex) {
      Logger().e(ex);
      return FResult.error(ex.toString());
    }
  }
}
