import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../Core/Localization/change_lang.dart';
import '../../widget/Custom%20Material%20Button/custom_material_button.dart';

class Language extends GetView<LocaleController> {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Choose Language".tr,
              ),
              const SizedBox(height: 20),
              CustomMaterialButton(
                  buttonText: "Ar",
                  onPressed: () {
                    controller.changeLang("ar");
                  }),
              CustomMaterialButton(
                  buttonText: "En",
                  onPressed: () {
                    controller.changeLang("en");
                  })
            ],
          )),
    );
  }
}
