// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';
import 'package:it_project/src/utils/app_shared.dart';

class FUserLocal {
  FUserLocal(this._box);
  final Box<dynamic> _box;
  late final _appShared = AppSharedUser(_box);

  void logOut() => _appShared.setFUserValue(null);

  set fUser(FUserLocalDao? fUser) => _appShared.setFUserValue(fUser);
  FUserLocalDao? get fUser => _appShared.getFUserValue();

  String? get refreshToken => _appShared.getFUserValue()?.refreshToken;
  String? get userId => _appShared.getFUserValue()?.userId;
  String? get acceptToken => _appShared.getFUserValue()?.accessToken;
  String? get phoneNumber => _appShared.getFUserValue()?.phoneNumber;
  String? get avatar => _appShared.getFUserValue()?.avatar;
  String? get name => _appShared.getFUserValue()?.name;

  bool get isLogged => _appShared.getFUserValue() != null;
}