import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Auth_controller/get_photo.dart';
import 'package:smart_tourism/Core/constants/images.dart';
import 'package:smart_tourism/View/Profile/widget/Profile%20Personal%20Data/pages/edit_image.dart';
import '../../../../../Core/constants/font.dart';
import '../../../../../Controller/Auth_controller/user_information_controller.dart';
import '../widgets/display_image_widget.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final UserInformation userInformation = Get.put(UserInformation());
  PhotoController profilePhotoController = Get.put(PhotoController());

  @override
  void initState() {
    super.initState();
    userInformation.getUserInfo().then((_) {
      final user = userInformation.userInfo['user_info'] ?? {};
      final userImage = user['profile_photo'];
      if (userImage != null) {
        profilePhotoController.GetProfileImage(userImage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userInformation.isLoading.value) {
        return Center(
          child: Text('Loading user information...'),
        );
      }

      final userInfo = userInformation.userInfo;
      if (userInfo.isEmpty) {
        return Center(
          child: Text('No user information available'),
        );
      }

      final user = userInfo['user_info'] ?? {};

      return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20.h),
        children: [
          DisplayImage(
            imagePath: profilePhotoController.profileImage.value,
            onPressed: () {
              Get.to(() => EditImageProfile());
            },
          ),
          SizedBox(height: 20.h),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                UserInfoTile(
                  label: 'First Name',
                  value: user['first_name'] ?? 'N/A',
                ),
                UserInfoTile(
                  label: 'Last Name',
                  value: user['last_name'] ?? 'N/A',
                ),
                UserInfoTile(
                  label: 'Email',
                  value: user['email'] ?? 'N/A',
                ),
                UserInfoTile(
                  label: 'Location',
                  value: user['location'] ?? 'N/A',
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class UserInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w400,
          fontFamily: TextFontStyle.Mano,
        ),
        textAlign: TextAlign.start,
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.teal,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
