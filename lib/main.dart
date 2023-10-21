import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/constants/ThemesStyle.dart';
import 'package:smart_tourism/presentation/View/SplashView.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(DevicePreview(
        enabled: false,
        builder: (context) => const SmartTourism(), // Wrap your app
      )));
}

class SmartTourism extends StatelessWidget {
  const SmartTourism({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme, // Set the dark theme
            themeMode: ThemeMode
                .system, // Enable automatic theme switching based on device settings
            title: 'Smart Tourism',
            home: const SplashView(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
