import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../utils/app_shared.dart';
import 'lang_en.dart';
import 'lang_vi.dart';

class TranslationManager extends Translations {
  final AppShared appShared;
  late Locale _locale;

  // Get current locate
  Locale get locale {
    return _locale;
  }

  // constructor
  TranslationManager(this.appShared) {
    _initLanguageCodeFromCached();
  }

  /// convert string to Locate
  Locale? _convertStringToLocale(String locate) =>
      appLocales.firstWhereOrNull((element) => element.languageCode == locate);

  // Init language code when load app
  _initLanguageCodeFromCached() async {
    // Get language from cache
    String? cachedLanguage = appShared.getLanguageCode();

    if (cachedLanguage == null) {
      // If cache null set default locale
      _locale = appLocales.contains(Get.deviceLocale)
          ? (Get.deviceLocale ?? fallbackLocaleUS) // default with device locate
          : fallbackLocaleUS; // default en

      // save to Hive
      appShared.setLanguageCode(_locale.languageCode);
    } else {
      _locale = _convertStringToLocale(cachedLanguage) ?? fallbackLocaleUS;
    }
  }

  static Locale fallbackLocaleVN = const Locale('vi', 'VN');
  static Locale fallbackLocaleUS = const Locale('en', 'US');

  List<Locale> appLocales = [
    fallbackLocaleUS,
    fallbackLocaleVN,
  ];

  /// Support translate language
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'vi_VN': viVN,
      };

  /// Update [locale] to GetX and AppShared.
  Future<void> updateLocale(Locale locale) async {
    // update to getX
    Get.updateLocale(locale);

    // update to Hive
    await appShared.setLanguageCode(locale.languageCode);

    // update to global variable
    _locale = locale;
  }

  Locale getLocale(String languageCode) {
    if (fallbackLocaleVN.languageCode == languageCode) {
      return fallbackLocaleVN;
    } else {
      return fallbackLocaleUS;
    }
  }
}
