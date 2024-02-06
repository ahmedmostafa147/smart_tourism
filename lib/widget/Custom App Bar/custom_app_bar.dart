import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  CustomAppBar({Key? key, required this.text}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 35.r,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
