import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../Controller/Auth_controller/user_information_controller.dart';

class UserInfoScreen extends StatelessWidget {
  final UserInformation userInformation = Get.put(UserInformation());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userInformation.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      try {
        userInformation.getUserInfo();
      } catch (e) {
        print(e);
      }

      final userInfo = userInformation.userInfo;
      final user = userInfo['user_info'];

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          UserInfoTile(label: 'First Name', value: user['first_name'] ?? ''),
          UserInfoTile(label: 'Last Name', value: user['last_name'] ?? ''),
          UserInfoTile(label: 'Email', value: user['email'] ?? ''),
          UserInfoTile(label: 'Location', value: user['location'] ?? ''),
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
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
