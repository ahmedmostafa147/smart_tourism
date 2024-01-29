import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomOptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomOption(icon: FontAwesomeIcons.bowlFood, label: 'Restaurant'),
            CustomOption(icon: FontAwesomeIcons.hotel, label: 'Hotel'),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomOption(icon: FontAwesomeIcons.houseChimney, label: 'Places'),
            CustomOption(icon: FontAwesomeIcons.listCheck, label: 'To Do List'),
          ],
        ),
      ],
    );
  }
}

class CustomOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const CustomOption({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.teal[300],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Row(
          children: [
            Icon(
              icon,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 17.0.sp),
            ),
          ],
        ),
      ),
    );
  }
}
