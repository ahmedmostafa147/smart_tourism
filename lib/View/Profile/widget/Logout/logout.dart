import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/logout_controller.dart';

class Logout extends StatelessWidget {
   Logout({super.key});

  @override
  Widget build(BuildContext context) {
    final LogoutController logoutController = Get.put(LogoutController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to logout?'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
                onPressed: () {
                  logoutController.logout();
                },
                child: Text('Logout'.tr))
          ],
        ),
      ),
    );
  }
 }
