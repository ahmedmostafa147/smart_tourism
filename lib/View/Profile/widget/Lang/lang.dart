import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Controller/local_controller.dart';

class Language extends GetView<LocaleController> {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choose Language".tr,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    child: Text(
                      "Ar",
                    ),
                    onPressed: () {
                      controller.changeLang("ar");
                      Get.back();
                    }),
                     const SizedBox(height: 20),
            ElevatedButton(
                child: Text(
                  "En",
                ),
                onPressed: () {
                  controller.changeLang("en");
                  Get.back();
                })
              ],
            ),
           
          ],
        ));
  }
}
