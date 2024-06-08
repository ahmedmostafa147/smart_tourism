import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../Core/constants/font.dart';
import '../../../../../Core/constants/images.dart';
import '../../../../../Controller/Auth_controller/user_information_controller.dart';
import '../widgets/display_image_widget.dart';

class UserInfoScreen extends StatelessWidget {
  final UserInformation userInformation = Get.put(UserInformation());

  @override
  Widget build(BuildContext context) {
    userInformation.getUserInfo();

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
      final userImage = user['image'] ?? Assets.imagesCircleUser;

      return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20.h),
        children: [
          DisplayImage(
            imagePath: userImage,
            onPressed: () {},
          ),
          SizedBox(height: 20.h),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              UserInfoTile(
                  label: 'First Name', value: user['first_name'] ?? 'N/A'),
              UserInfoTile(
                  label: 'Last Name', value: user['last_name'] ?? 'N/A'),
              UserInfoTile(label: 'Email', value: user['email'] ?? 'N/A'),
              UserInfoTile(label: 'Location', value: user['location'] ?? 'N/A'),
            ]),
          ),
        ],
      );
    });
  }
}

class UserInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          textAlign: TextAlign.start),
      subtitle: Text(value,
          style: TextStyle(fontSize: 14.sp,color: Colors.teal, fontFamily: TextFontStyle.Play),
          textAlign: TextAlign.start,),
    );
  }
}
