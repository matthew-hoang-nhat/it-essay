import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/repository/up_file_repository.dart';

class UpFileRepositoryImpl extends UpFileRepository {
  UpFileRepositoryImpl({required super.upFileService});

  @override
  Future<FResult<String>> uploadFile(XFile file) async {
    try {
      final response = await upFileService.uploadFile(attach: File(file.path));
      return FResult.success(response['fileLink']);
    } catch (ex) {
      print('uploadFile: $ex');
      return FResult.error(ex.toString());
    }
  }
}
