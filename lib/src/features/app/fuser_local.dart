// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';
import 'package:it_project/src/services/socket_manager.dart';
import 'package:it_project/src/utils/app_shared.dart';

class FUserLocal {
  final Box<dynamic> _box = getIt<Box>();
  late final _appShared = AppSharedUser(_box);

  void logOut() => _appShared.setFUserValue(null);

  set fUser(FUserLocalDao? fUser) {
    final newToken = fUser?.accessToken;
    _appShared.setFUserValue(fUser);

    if (newToken != acceptToken) {
      getIt<SocketManager>().connect();
    }
  }

  FUserLocalDao? get fUser => _appShared.getFUserValue();
  String? get refreshToken => _appShared.getFUserValue()?.refreshToken;
  String? get userId => _appShared.getFUserValue()?.userId;
  String? get acceptToken => _appShared.getFUserValue()?.accessToken;
  String? get phoneNumber => _appShared.getFUserValue()?.phoneNumber;
  String? get avatar => _appShared.getFUserValue()?.avatar;
  String? get firstName => _appShared.getFUserValue()?.firstName;
  String? get lastName => _appShared.getFUserValue()?.lastName;

  bool get isLogged => _appShared.getFUserValue() != null;
}
