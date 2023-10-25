import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/constants/ThemesStyle.dart';
import 'package:smart_tourism/presentation/View/SplashView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting().then((_) => runApp(DevicePreview(
        enabled: false,
        builder: (context) => const SmartTourism(), // Wrap your app
      )));
}

class SmartTourism extends StatefulWidget {
  const SmartTourism({Key? key}) : super(key: key);

  @override
  State<SmartTourism> createState() => _SmartTourismState();
}

class _SmartTourismState extends State<SmartTourism> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
    super.initState();
  }

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
                .light, // Enable automatic theme switching based on device settings
            title: 'Smart Tourism',
            home: MyCustomSplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
