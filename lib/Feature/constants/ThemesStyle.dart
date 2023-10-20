import 'package:flutter/material.dart';
import 'package:smart_tourism/Feature/constants/TextFontStyle.dart';


final ThemeData lightTheme = ThemeData(
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all<Color>(Colors.teal),
    trackColor: MaterialStateProperty.all<Color>(
        const Color.fromARGB(255, 255, 255, 255)),
    trackOutlineColor: MaterialStateProperty.all<Color>(Colors.teal),
  ),
  iconTheme: const IconThemeData(color: Colors.teal),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.teal),
  )),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.teal,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.teal,
    thickness: 1.0,
  ),
  fontFamily: TextFontStyle.cairoFont,
  useMaterial3: true,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0
  ),
);

final ThemeData darkTheme = ThemeData(
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all<Color>(Colors.amber),
    trackColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.amber),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.amber),
  )),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0XFFD4A331),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0XFFD4A331),
    thickness: 1.0,
  ),
  fontFamily: TextFontStyle.cairoFont,
  useMaterial3: true,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0
  ),
);
