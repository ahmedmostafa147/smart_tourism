import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Auth_controller/get_photo.dart';
import 'package:smart_tourism/Controller/Auth_controller/user_information_controller.dart';
import '../../../Controller/Location/location_controller.dart';
import '../../../Core/constants/images.dart';
import '../../Profile/widget/Logout/logout.dart';

class CustomAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarHome({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.put(LocationController());
    final UserInformation userInformation = Get.put(UserInformation());
    PhotoController profilePhotoController = Get.put(PhotoController());

    userInformation.getUserInfo().then((_) {
      final user = userInformation.userInfo['user_info'] ?? {};
      final userImage = user['profile_photo'];
      if (userImage != null) {
        profilePhotoController.GetProfileImage(userImage);
      }
    });

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed('/ChatScreen');
            },
            child: Row(
              children: [
                Image.asset(
                  Assets.imagesMessages,
                  width: 20.h,
                  height: 20.w,
                  color: Colors.teal,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  'AI Chat',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
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
              Get.toNamed('/ProfilePage');
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Obx(() {
                if (profilePhotoController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                return CachedNetworkImage(
                  imageUrl: profilePhotoController.profileImage.value,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Image.asset(
                    Assets.imagesCircleUser,
                    fit: BoxFit.fill,
                    width: 40.0,
                    height: 40.0,
                    color: Colors.teal,
                    alignment: Alignment.center,
                  ),
                );
              }),
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
