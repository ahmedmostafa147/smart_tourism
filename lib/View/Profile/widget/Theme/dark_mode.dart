import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Controller/local_controller.dart';
import '../../../../widget/Custom Material Button/custom_material_button.dart';

class ChooseThemeMode extends GetView<LocaleController> {
  const ChooseThemeMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {
        Get.back();
      },
      builder: (context) => Container(
        height: 300.h,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Choose Mode".tr),
            const SizedBox(height: 20),
            CustomMaterialButton(
              buttonText: "System",
              onPressed: () async {
                controller.changeTheme(ThemeMode.system);
                Get.back();
              },
            ),
            const SizedBox(height: 20),
            CustomMaterialButton(
              buttonText: "Light",
              onPressed: () async {
                controller.changeTheme(ThemeMode.light);
                Get.back();
              },
            ),
            const SizedBox(height: 20),
            CustomMaterialButton(
              buttonText: "Dark",
              onPressed: () async {
                controller.changeTheme(ThemeMode.dark);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
