import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Auth_controller/delete_acc_controller.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final DeleteAccController deleteAccController =
        Get.put(DeleteAccController());
    return Container(
      padding: EdgeInsets.all(20.r),
      height: 150.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(
            'Are you sure you want to delete your account?'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               ElevatedButton(
                    child: Text('Yes'.tr),
                    onPressed: () {
                      deleteAccController.deleteUserAccount();
                    }),
              
              ElevatedButton(
                  child: Text('No'.tr),
                  onPressed: () {
                    Get.back();
                  })
            ],
          ),
        ],
      ),
    );
  }
}
