import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'widgets/app_bar_home.dart';
import 'widgets/container_center_home_screen.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarHome(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover'.tr,
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 32.sp,
                    height: 1.3.sp,
                    fontFamily: "Mano"),
              ),
              SizedBox(
                height: 15.h,
              ),
              ContainerOPtionsSearch(),
              SizedBox(
                height: 24.h,
              ),
              Text(
                'You may like this '.tr,
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20.sp,
                    height: 1.3.sp,
                    fontFamily: "Mano"),
              ),
              Text(
                'You may like this Place'.tr,
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20.sp,
                    height: 1.3.sp,
                    fontFamily: "Mano"),
              ),
              Text(
                'You may like this '.tr,
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20.sp,
                    height: 1.3.sp,
                    fontFamily: "Mano"),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'You may like this Restaurant'.tr,
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 17.sp,
                    height: 1.3.sp,
                    fontFamily: "Mano"),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'You may like this Hotels '.tr,
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20.sp,
                    height: 1.3.sp,
                    fontFamily: "Mano"),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
