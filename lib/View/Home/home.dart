import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_tourism/View/Home/widgets/app_bar_home.dart';
import 'package:smart_tourism/View/Home/widgets/container_center_home_screen.dart';
import 'package:smart_tourism/View/Home/widgets/container_display_nearest.dart';
import 'package:smart_tourism/View/Home/widgets/list_view_discover_places.dart';
import 'package:smart_tourism/View/Home/widgets/det.dart';
import 'package:smart_tourism/constants/ImagesForFullApp.dart';

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
              RichText(
                text: TextSpan(
                  text: 'Discover',
                  style: const TextStyle(
                      color: Colors.teal, fontSize: 32, height: 1.3),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomOptionsWidget(),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nearest to you',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(fontSize: 17.sp, color: Colors.teal),
                  ),
                ],
              ),
             ContainerDisplayNearestHome(),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover Places',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(fontSize: 17.sp, color: Colors.teal),
                  ),
                ],
              ),
              ListDiscoverPlaces(),
            ],
          ),
        ),
      ),
    );
  }
}
