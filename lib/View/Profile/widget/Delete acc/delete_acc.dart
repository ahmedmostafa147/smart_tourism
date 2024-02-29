import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/delete_acc_controller.dart';
import 'package:smart_tourism/widget/Custom%20Material%20Button/custom_material_button.dart';

class DeleteAccountScreen extends StatelessWidget {
  final DeleteAccController deleteAccController =
      Get.put(DeleteAccController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Account'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to delete your account?'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            CustomMaterialButton(
                buttonText: deleteAccController.isLoading.value
                    ? 'Loading...'.tr
                    : 'Delete Account'.tr,
                onPressed: () {
                  deleteAccController.isLoading.value
                      ? null
                      : () async {
                          await deleteAccController.deleteAccount(2);
                        };
                })
          ],
        ),
      ),
    );
  }
}
