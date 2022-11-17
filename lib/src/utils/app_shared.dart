import 'dart:async';

import 'package:hive/hive.dart';
import 'package:it_project/src/local/dao/item_cart.dart';

class AppShared {
  final Box<dynamic> _box;
  AppShared(this._box);
  static const String keyName = 'BookCommerce';
  static const String keyBox = '${keyName}_shared';
  final String keyTokenValue = "${keyName}_keyTokenValue";
  final String keyRefreshTokenValue = "${keyName}_keyRefreshTokenValue";
  final String keyUserIdValue = "${keyName}_keyUserIdValue";
  final String keyCartValue = "${keyName}_keyCartValue";

  Future<void> setTokenValue(String? value) => _box.put(keyTokenValue, value);
  String? getTokenValue() => _box.get(keyTokenValue);

  Future<void> setRefreshTokenValue(String? value) =>
      _box.put(keyRefreshTokenValue, value);
  String? getRefreshTokenValue() => _box.get(keyRefreshTokenValue);

  Future<void> setUserIdValue(String? value) => _box.put(keyUserIdValue, value);
  String? getUserIdValue() => _box.get(keyUserIdValue);

  List<dynamic>? getItemCartsValue() => _box.get(keyCartValue);

  Future<void>? setItemCartsValue(List<ItemCart> value) =>
      _box.put(keyCartValue, value);

  Future<int> clear() => _box.clear();
}
