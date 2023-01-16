import 'dart:async';

import 'package:hive/hive.dart';
import 'package:it_project/src/configs/constants/app_constants.dart';
import 'package:it_project/src/local/dao/f_user_local_dao.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';

class AppSharedUser {
  AppSharedUser(this._box);
  final Box<dynamic> _box;
  static const String keyFUserValue = "${AppConstants.keyBox}_keyFUserValue";

  Future<void> setFUserValue(FUserLocalDao? value) =>
      _box.put(keyFUserValue, value);
  FUserLocalDao? getFUserValue() => _box.get(keyFUserValue);
}

class AppSharedCart {
  final Box<dynamic> _box;
  AppSharedCart(this._box);
  final String _keyCartValue = "${AppConstants.keyName}_keyCartValue";

  List<dynamic>? getItemCartsValue() => _box.get(_keyCartValue);
  Future<void>? setItemCartsValue(List<ItemCart> value) =>
      _box.put(_keyCartValue, value);
}
