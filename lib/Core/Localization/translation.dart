import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "Choose Language": "اختر اللغة",
          "Select Your Preferred Types of Tourism":
              "اختر أنواع السياحة المفضلة",
          "Tourism Preferences": "تفضيلات السياحة",
          "Submit": "إرسال",
        },
        "en": {
          "Choose Language": "Choose Language",
          "Select Your Preferred Types of Tourism":
              "Select Your Preferred Types of Tourism",
          "Tourism Preferences": "Tourism Preferences",
          "Submit": "Submit",
        }
      };
}
