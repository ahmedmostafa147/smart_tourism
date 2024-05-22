import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Controller/local_controller.dart';

class ChooseThemeMode extends GetView<LocaleController> {
  const ChooseThemeMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      height: 300.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Choose Mode".tr),
          SizedBox(height: 20.h),
          ElevatedButton(
            child: Text("System"),
            onPressed: () async {
              controller.changeTheme(ThemeMode.system);
              Get.back();
            },
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            child: Text("Light"),
            onPressed: () async {
              controller.changeTheme(ThemeMode.light);
              Get.back();
            },
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () async {
              controller.changeTheme(ThemeMode.dark);
              Get.back();
            },
            child: Text('"Dark"'.tr),
          ),
        ],
      ),
    );
  }
}
