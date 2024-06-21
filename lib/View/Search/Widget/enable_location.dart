import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContainerEnableLocation extends StatelessWidget {
  const ContainerEnableLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nearest to you'.tr,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'View All'.tr,
              style: TextStyle(fontSize: 17.sp, color: Colors.teal),
            ),
          ],
        ),
        SizedBox(
          height: 24.h,
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Discover Places'.tr,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'View All'.tr,
              style: TextStyle(fontSize: 17.sp, color: Colors.teal),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
