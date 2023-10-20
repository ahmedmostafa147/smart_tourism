import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Feature/presentation/View/SplashView.dart';
import 'package:smart_tourism/Feature/constants/ThemesStyle.dart';

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
            title: 'Muslim',
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
