import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../../../Controller/local_controller.dart';
import '../../../../widget/Custom%20Material%20Button/custom_material_button.dart';

class Language extends GetView<LocaleController> {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {
        Get.back();
      },
      builder: (context) => Container(
        height: 200.h,
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
                     Get.back();
                  }),
                   const SizedBox(height: 20),
              CustomMaterialButton(
                  buttonText: "En",
                  onPressed: () {
                    controller.changeLang("en");
                     Get.back();
                  })
            ],
          )),
    );
  }
}
