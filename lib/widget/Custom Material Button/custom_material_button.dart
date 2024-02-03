import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Add border radius
        boxShadow: [
          // Add box shadow
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: MaterialButton(
        height: 40.h,
        color: color ?? Colors.teal,
        textColor: Colors.white,
        onPressed: onPressed as void Function()?,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(buttonText),
      ),
    );
  }
}