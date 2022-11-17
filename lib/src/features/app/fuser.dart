// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:it_project/main.dart';
import 'package:it_project/src/utils/app_shared.dart';

class FUserLocal {
  FUserLocal();
  final _appShared = getIt<AppShared>();

  setUser(
      {required String userId,
      required String refreshToken,
      required String acceptToken}) {
    _appShared.setUserIdValue(userId);
    _appShared.setRefreshTokenValue(refreshToken);
    _appShared.setTokenValue(acceptToken);
  }

  logOut() {
    _appShared.setUserIdValue(null);
    _appShared.setRefreshTokenValue(null);
    _appShared.setTokenValue(null);
  }

  String? get refreshToken => _appShared.getRefreshTokenValue();
  String? get userId => _appShared.getUserIdValue();
  String? get acceptToken => _appShared.getTokenValue();
  bool get isLogged => _appShared.getTokenValue() != null;
}
