import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import '../../../Controller/location_controller.dart';
import '../../../Core/constants/images.dart';
import '../../Profile/widget/Logout/logout.dart';

class CustomAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarHome({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.put(LocationController());
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              locationController.getCurrentLocation();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.pin_drop_outlined,
                ),
                const SizedBox(
                  width: 2,
                ),
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
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed('/profile');
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.asset(
                Assets.imagesProfile,
                width: 40.h,
                height: 40.w,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.bottomSheet(Logout());
          },
          icon: Icon(
            Icons.logout,
          ),
        )
      ],
    );
  }
}
