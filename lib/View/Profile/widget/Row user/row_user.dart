import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Auth_controller/get_photo.dart';
import '../../../../Core/constants/font.dart';
import '../../../../Controller/Auth_controller/user_information_controller.dart';
import '../../../../Core/constants/images.dart';
import '../../../../Controller/Location/location_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RowUser extends StatelessWidget {
  final LocationController locationController = Get.find();
  final UserInformationRow userInformation = Get.put(
    UserInformationRow(),
  );

  final PhotoController profilePhotoController = Get.put(PhotoController());

  RowUser({super.key});

  @override
  Widget build(BuildContext context) {
    userInformation.getUserInfoRow().then((_) {
      final user = userInformation.userInfo['user_info'] ?? {};
      final userImage = user['profile_photo'];
      if (userImage != null) {
        profilePhotoController.GetProfileImage(userImage);
      }
    });

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
            CircleAvatar(
              radius: 25.w,
              backgroundImage: CachedNetworkImageProvider(
                profilePhotoController.profileImage.value ??
                    Assets.imagesCircleUser,
              ),
              backgroundColor: Theme.of(context).primaryColor,
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
