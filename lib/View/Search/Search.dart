import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Widget/recent_search.dart';
import 'Widget/text_field_search.dart';

import 'Widget/result_search.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.to(() => ResultSearch());
                  },
                  child: TextFieldSearch()),
              SizedBox(height: 20.h),
              Container(
                height: 50.h,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 30.r,
                      color: Colors.teal,
                    ),
                    SizedBox(width: 10.w),
                    Text("Nearby for YOU ".tr),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Divider(),
              SizedBox(height: 20.h),
              Text(
                "Recent Search:".tr,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              RecentSearchesWidget(),
              SizedBox(height: 20.h),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
