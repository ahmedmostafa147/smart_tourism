import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_tourism/Core/constants/font.dart';

class CustomMaterialButton extends StatelessWidget {
  final String buttonText;
  final Function? onPressed;
  final Color? color;
  final IconData? fontAwesomeIcons;

  const CustomMaterialButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.color,
      this.fontAwesomeIcons});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40.h,
      minWidth: double.infinity,
      color: color ?? Colors.teal,
      textColor: Colors.white,
      onPressed: onPressed as void Function()?,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(buttonText,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: TextFontStyle.Mano
          )),
    );
  }
}
