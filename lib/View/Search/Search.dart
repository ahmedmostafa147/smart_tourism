import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Widget/container_recent_search.dart';
import 'Widget/enable_location.dart';
import 'Widget/text_field_search.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              TextFieldSearch(),
              Divider(),
              SizedBox(height: 10.h),
              Text(
                'Your Recent Searches'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              ContainerRecentSearch(),
              Divider(),
              SizedBox(height: 20.h),
              ContainerEnableLocation()
            ],
          ),
        ),
      ),
    );
  }
}
