import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Controller/Auth_controller/logout_controller.dart';

class Logout extends StatelessWidget {
  Logout({super.key});

  @override
  Widget build(BuildContext context) {
    final LogoutController logoutController = Get.put(LogoutController());
    return Container(
      padding: EdgeInsets.all(20.r),
      height: 120.h,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(
            'Are you sure you want to logout?'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await logoutController.logout();
                      },
                      child: Text(
                        logoutController.isLoading.value
                            ? 'Loading...'
                            : 'Yes'.tr,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('No'.tr)),
                ],
              ))
        ],
      ),
    );
  }
}
