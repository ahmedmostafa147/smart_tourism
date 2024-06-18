import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/View/Plan/history_plan.dart';
import 'widget/about/about.dart';
import 'widget/Logout/logout.dart';
import 'widget/Notification/notifiction.dart';
import 'widget/Profile Personal Data/profile_page.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RowUser(),
              SizedBox(
                height: 20.h,
              ),
              RowOptions(
                  onTap: () {
                    Get.to(() => ProfilePage());
                  },
                  text: "Personal Data".tr,
                  IconName:
                      const ImageIcon(AssetImage(Assets.imagesCircleUser))),
              SizedBox(
                height: 20.h,
              ),
              RowOptions(
                  onTap: () {
                    Get.to(() => SavedPlansScreen());
                  },
                  text: "Plans".tr,
                  IconName: const ImageIcon(AssetImage(Assets.imagesBusiness))),
              SizedBox(
                height: 20.h,
              ),
              RowOptions(
                text: "Survey",
                IconName: const ImageIcon(AssetImage(Assets.imagesChecklist)),
                onTap: () {
                  Get.toNamed('/ResultSurvey');
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              RowOptions(
                text: "AI Chat",
                IconName: const ImageIcon(AssetImage(Assets.imagesMessages)),
                onTap: () {
                  Get.toNamed('/ChatScreen');
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              RowOptions(
                  onTap: () {
                    Get.bottomSheet(NotificationView());
                  },
                  text: "Notifications".tr,
                  IconName: const ImageIcon(AssetImage(Assets.imagesRinging))),
              SizedBox(
                height: 20.h,
              ),
              RowOptions(
                  onTap: () {
                    Get.bottomSheet(const Language());
                  },
                  text: "Language,تغير اللغة",
                  IconName: const ImageIcon(AssetImage(Assets.imagesArabic))),
              SizedBox(
                height: 20.h,
              ),
              RowOptions(
                onTap: () {
                  Get.bottomSheet(const ChooseThemeMode());
                },
                text: "Dark Mode".tr,
                IconName: const ImageIcon(AssetImage(Assets.imagesDayAndNight)),
              ),
              SizedBox(
                height: 20.h,
              ),
              RowOptions(
                  onTap: () {
                    Get.bottomSheet(AboutView());
                  },
                  text: "About".tr,
                  IconName: const ImageIcon(AssetImage(Assets.imagesAbout))),
              SizedBox(
                height: 20.h,
              ),
              RowOptions(
                  onTap: () {
                    Get.bottomSheet(DeleteAccountScreen());
                  },
                  text: "Delete Account".tr,
                  IconName: const ImageIcon(AssetImage(Assets.imagesDelete))),
              SizedBox(
                height: 20.h,
              ),
              RowOptions(
                  onTap: () {
                    Get.bottomSheet(Logout());
                  },
                  text: "Logout".tr,
                  IconName: const ImageIcon(AssetImage(Assets.imagesLogout))),
            ],
          ),
        ),
      ),
    );
  }
}
