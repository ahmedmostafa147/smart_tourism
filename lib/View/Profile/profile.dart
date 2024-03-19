import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/View/Profile/widget/Logout/logout.dart';
import 'package:smart_tourism/View/Profile/widget/Profile%20Personal%20Data/pages/profile_page.dart';
import 'widget/Delete%20acc/delete_acc.dart';
import 'widget/Lang/lang.dart';
import 'widget/Row%20user/row_user.dart';
import 'widget/Row%20Options/row_options.dart';
import 'widget/Theme/dark_mode.dart';
import '../../Core/constants/images.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            RowUser(),
            RowOptions(
                onTap: () {
                  Get.to(ProfilePage());
                },
                text: "Personal Data".tr,
                IconName: const ImageIcon(AssetImage(Assets.imagesCircleUser))),
            RowOptions(
                onTap: () {},
                text: "Plans".tr,
                IconName: const ImageIcon(AssetImage(Assets.imagesBusiness))),
            RowOptions(
                onTap: () {},
                text: "Notifications".tr,
                IconName: const ImageIcon(AssetImage(Assets.imagesRinging))),
            RowOptions(
                onTap: () {
                  Get.bottomSheet(const Language());
                },
                text: "Language,تغير اللغة",
                IconName: const ImageIcon(AssetImage(Assets.imagesArabic))),
            RowOptions(
              onTap: () {
                Get.bottomSheet(const ChooseThemeMode());
              },
              text: "Dark Mode".tr,
              IconName: const ImageIcon(AssetImage(Assets.imagesDayAndNight)),
            ),
            RowOptions(
                onTap: () {
                  Get.bottomSheet(DeleteAccountScreen());
                },
                text: "Delete Account".tr,
                IconName: const ImageIcon(AssetImage(Assets.imagesDelete))),
            RowOptions(
                onTap: () {},
                text: "About".tr,
                IconName: const ImageIcon(AssetImage(Assets.imagesAbout))),
            RowOptions(
                onTap: () async {
                  {
                    Get.bottomSheet(Logout());
                  }
                  ;
                },
                text: "Logout".tr,
                IconName: const ImageIcon(AssetImage(Assets.imagesLogout))),
          ],
        ),
      ),
    );
  }
}
