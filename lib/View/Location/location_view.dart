import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/location_controller.dart';
import '../../Core/constants/images.dart';
import '../Auth/AuthWidget/custom_button_auth.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    LocationController controller = Get.put(LocationController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enable Location',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 200,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Image.asset(
                  Assets.imagesMap,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Please enable location services to continue, this will help us to find the best service providers near you.',
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
          Obx(() => CustomButtonAuth(
                onPressed: () async {
                  await controller.getCurrentLocation();
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  final List<String>? survey = prefs.getStringList('survey');
                  if (survey == null || survey.isEmpty) {
                    Get.offNamed('/survey');
                  } else {
                    Get.offNamed('/bottomNavBar');
                  }
                },
                title: controller.isLoading.value
                    ? 'Loading...'
                    : 'Enable Location',
              )),
        ],
      ),
    );
  }
}
