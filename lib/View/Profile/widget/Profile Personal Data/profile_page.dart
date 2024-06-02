import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Profile%20Personal%20Data/pages/User_Information.dart';
import '../Profile%20Personal%20Data/pages/update_profile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(UpdateUserProfileScreen());
            },
            icon: Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              UserInfoScreen(), // Use the UserInfoScreen as a widget here
            ],
          ),
        ),
      ),
    );
  }
}
