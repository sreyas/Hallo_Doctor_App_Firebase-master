import 'dart:ui';

import 'package:get/get.dart';

import '../services/settings_service.dart';
import '../translation/en_US.dart';
import '../translation/fr.dart';
import '../translation/ur_PK.dart';

class LocalizationService extends Translations {
  static final locale = Locale('en', "US");

  static final langs = ['English', "Urdu", 'France'];

  static final locales = [
    Locale('en', 'US'),
    Locale('ur', 'PK'),
    Locale('fr', null)
  ];
  Map<String, String> myEn = {};
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>
      {'en_US': myEn, 'ur_PK': ur, 'fr': fr};
  LocalizationService() {}
  LocalizationService._create() {
    print("_create() (private constructor)");
  }
  Future<LocalizationService> create() async {
    var component = LocalizationService._create();
    int serverLanguageVersion =
        await SettingsService().getServerLanguageVersion();
    if (!await _checkLanguageVersion(serverLanguageVersion)) {
      updateLanguage();
    } else {
      component.myEn = await SettingsService().getLocalLanguage();
    }

    return component;
  }

  ///check language version if true, than language is no change, if false language is change in db
  Future<bool> _checkLanguageVersion(int currentLanguageVersion) async {
    int? languageVersion = await SettingsService().getLocalLanguageVersion();
    if (languageVersion == null || languageVersion != currentLanguageVersion) {
      return false;
    }
    return true;
  }

  Future updateLanguage() async {
    try {
      await SettingsService().updateLocalLanguage();
    } catch (e) {
      return Future.error(e);
    }
  }

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    int index = langs.indexOf(lang);
    return locales[index];
  }
}
