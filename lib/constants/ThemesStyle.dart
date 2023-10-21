import 'package:flutter/material.dart';
import 'package:smart_tourism/constants/TextFontStyle.dart';

final ThemeData lightTheme = ThemeData(
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
  dividerTheme: const DividerThemeData(
    thickness: 1.0,
  ),
  fontFamily: TextFontStyle.cairoFont,
  useMaterial3: true,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
);

final ThemeData darkTheme = ThemeData(
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
  dividerTheme: const DividerThemeData(
    thickness: 1.0,
  ),
  useMaterial3: true,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
);
