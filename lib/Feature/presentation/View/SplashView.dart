import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_tourism/Feature/presentation/View/Home.dart';
import 'package:smart_tourism/Feature/constants/ThemesStyle.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 1200,
        splashIconSize: 150.h,
        splash: Image.asset(
          'lib/Assets/Images/SplashViewImage.png',
        ),
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.theme,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? darkTheme.scaffoldBackgroundColor
            : lightTheme.scaffoldBackgroundColor);
  }
}
