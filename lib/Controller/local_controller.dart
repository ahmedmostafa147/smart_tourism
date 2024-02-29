import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Core/Service/service.dart';

class LocaleController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();
  ThemeMode? themeData;
  

  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    Get.updateLocale(locale);
  }

  changeTheme(ThemeMode themeMode) {
    themeData = themeMode;
    myServices.sharedPreferences.setString("theme", themeMode.toString());
    Get.changeThemeMode(themeMode);
  }

  @override
  void onInit() {
    String? sharedPrefTheme = myServices.sharedPreferences.getString("theme");
    if (sharedPrefTheme == "ThemeMode.dark") {
      themeData = ThemeMode.dark;
    } else if (sharedPrefTheme == "ThemeMode.light") {
      themeData = ThemeMode.light;
    } else {
      themeData = ThemeMode.system;
    }
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
     
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
