import 'dart:async';

import 'package:hive/hive.dart';

class AppShared {
  final Box<dynamic> _box;
  AppShared(this._box);

  static const String keyName = 'BoostPTE';
  static const String keyBox = '${keyName}_shared';
  final String keyTokenValue = "${keyName}_keyTokenValue";
  final String keyLanguageCode = "${keyName}_keyLanguageCode";
  Future<void> setLanguageCode(String languageCode) =>
      _box.put(keyLanguageCode, languageCode);

  /*
  * Get Selected Locale
  */
  String? getLanguageCode() => _box.get(keyLanguageCode);
  Stream<String?> watchTokenValue() {
    return _box
        .watch(key: keyTokenValue)
        .transform(StreamTransformer.fromHandlers(handleData: (data, sink) {
      final value = data.value;
      sink.add(value);
    }));
  }

  Future<void> setTokenValue(String value) => _box.put(keyTokenValue, value);
  String? getTokenValue() => _box.get(keyTokenValue);

  Future<int> clear() => _box.clear();
}