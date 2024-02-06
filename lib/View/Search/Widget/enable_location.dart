import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Home/widgets/container_center_home_screen.dart';
import '../../Home/widgets/container_display_nearest.dart';
import '../../Home/widgets/list_view_discover_places.dart';

class ContainerEnableLocation extends StatelessWidget {
  const ContainerEnableLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Divider(),
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
        Divider(),
       
        ContainerDisplayNearestHome(),
        
       
      ],
    );
  }
}
