import 'package:image_picker/image_picker.dart';
import 'package:it_project/src/utils/remote/services/f_result.dart';
import 'package:it_project/src/utils/remote/services/up_file/up_file_service.dart';

abstract class UpFileRepository {
  final UpFileService upFileService;
  UpFileRepository({required this.upFileService});

  Future<FResult<String>> uploadFile(XFile file);
}
