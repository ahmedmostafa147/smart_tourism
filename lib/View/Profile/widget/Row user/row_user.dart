import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Core/constants/font.dart';
import '../../../../Controller/Auth_controller/user_information_controller.dart';
import '../../../../Core/constants/images.dart';
import '../../../../Controller/location_controller.dart';

class RowUser extends StatelessWidget {
  final LocationController locationController = Get.find();
  final UserInformationRow userInformation = Get.put(
    UserInformationRow(),
  );

  RowUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userInformation.isLoading.value) {
        return Center(
          child: Text('Loading User...'),
        );
      }

      final userInfo = userInformation.userInfo;
      if (userInfo.isEmpty) {
        return Center(
          child: Text('No user information available'),
        );
      }

      final user = userInfo['user_info'] ?? {};
      final userImage = user['image'] ?? Assets.imagesCircleUser;

      return Container(
        height: 80.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: Colors.teal, width: 2.w, style: BorderStyle.solid),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                userImage,
                width: 50.w,
                height: 50.h,
                fit: BoxFit.contain,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(width: 15.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['first_name'] ?? 'First Name',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: TextFontStyle.Mano),
                ),
                Text(
                  user['last_name'] ?? 'Last Name',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: TextFontStyle.Mano),
                ),
              ],
            ),
            Spacer(),
            _buildLocationContainer(context, locationController),
          ],
        ),
      );
    });
  }

  Widget _buildLocationContainer(
      BuildContext context, LocationController locationController) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Colors.teal, width: 2.w, style: BorderStyle.solid),
      ),
      child: Row(
        children: [
          Icon(
            Icons.pin_drop_outlined,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          SizedBox(width: 5.w),
          Obx(() {
            return locationController.isLoading.value
                ? Text(
                    'Loading...',
                    style: TextStyle(fontSize: 16.sp),
                  )
                : Text(
                    locationController.addressCountry.value,
                    style: TextStyle(fontSize: 16.sp),
                  );
          }),
          Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ],
      ),
    );
  }
}
