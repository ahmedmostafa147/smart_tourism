import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_tourism/View/Lang/lang.dart';
import 'package:smart_tourism/View/Profile/widget/Row%20user/row_user.dart';
import 'package:smart_tourism/View/Profile/widget/notifications.dart';
import 'package:smart_tourism/View/Profile/widget/personal_data.dart';
import 'package:smart_tourism/View/Profile/widget/Row%20Options/row_options.dart';
import 'package:smart_tourism/constants/images.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedLanguage = 'English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            RowUser(),
            
            RowOptions(
                text: "Personal Data",
                IconName: const ImageIcon(AssetImage(Assets.imagesHouseBlank))),
            RowOptions(
                text: "Plans",
                IconName: const ImageIcon(AssetImage(Assets.imagesHouseBlank))),
            RowOptions(
                text: "Notifications",
                IconName: const ImageIcon(AssetImage(Assets.imagesHouseBlank))),
            RowOptions(
                text: "Language,تغير اللغة",
                IconName: const ImageIcon(AssetImage(Assets.imagesHouseBlank))),
            RowOptions(
                text: "Dark Mode",
                IconName: const ImageIcon(AssetImage(Assets.imagesHouseBlank))),
            RowOptions(
                text: "Delete Account",
                IconName: const ImageIcon(AssetImage(Assets.imagesHouseBlank))),
            RowOptions(
                text: "About",
                IconName: const ImageIcon(AssetImage(Assets.imagesHouseBlank))),
            RowOptions(
                text: "Logout",
                IconName: const ImageIcon(AssetImage(Assets.imagesHouseBlank))),
          ],
        ),
      ),
    );
  }
}
