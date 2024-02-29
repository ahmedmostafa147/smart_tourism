import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/local_controller.dart';
import 'font.dart';
 


final ThemeData lightTheme = ThemeData(
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all<Color>(Colors.teal),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.zero,
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.teal,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
  dividerTheme: const DividerThemeData(
    thickness: 1.0,
  ),
    fontFamily: Get.find<LocaleController>().language == const Locale('ar')
      ? TextFontStyle.Cairo
      : TextFontStyle.Rubik,
  useMaterial3: true,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      actionsIconTheme: const IconThemeData(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.teal,
      foregroundColor: Colors.teal,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.sp)),
);

final ThemeData darkTheme = ThemeData(
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
  dividerTheme: const DividerThemeData(
    thickness: 1.0,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all<Color>(Colors.teal),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.zero,
      ),
    ),
  ),
  fontFamily: Get.find<LocaleController>().language == const Locale('ar')
      ? TextFontStyle.Cairo
      : TextFontStyle.Rubik,
  useMaterial3: true,
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      actionsIconTheme: const IconThemeData(color: Colors.black),
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.teal,
      foregroundColor: Colors.teal,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.sp)),
);
