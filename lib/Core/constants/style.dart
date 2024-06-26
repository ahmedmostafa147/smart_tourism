import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Controller/Lang/local_controller.dart';
import 'font.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.teal,
  colorScheme: const ColorScheme.light(
    primary: Colors.teal,
    secondary: Colors.teal,
    surface: Colors.white,
    background: Colors.white,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all<Color>(Colors.teal),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.teal,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
  dividerTheme: const DividerThemeData(thickness: 1.0),
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
    backgroundColor: Colors.blueGrey[900],
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.sp),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.teal,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Colors.teal,
    secondary: Colors.teal,
    surface: Color(0xFF212121),
    background: Color(0xFF121212),
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
  dividerTheme: const DividerThemeData(thickness: 1.0),
  iconTheme: const IconThemeData(color: Colors.white),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all<Color>(Colors.teal),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
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
    actionsIconTheme: const IconThemeData(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
    backgroundColor: Colors.blueGrey[900],
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 16.sp),
  ),
);
