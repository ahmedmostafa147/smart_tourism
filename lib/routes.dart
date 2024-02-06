import 'package:flutter/material.dart';
import 'View/Auth/Login/login.dart';
import 'View/Home/home.dart';
import 'View/Splash/splash_screen.dart';

class AppRoute {
  static const String login = "/login";
  static const String splash = "/splash";
  static const String home = "/home";
  static const String profile = "/profile";
  static const String settings = "/settings";
  static const String search = "/search";
  static const String plan = "/plan";
  static const String favorite = "/favorite";
  static const String bottomNaveBar = "/bottomNaveBar";
}

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.splash: (context) => MyCustomSplashScreen(),
  AppRoute.login: (context) => const LoginView(),
  AppRoute.home: (context) => const HomeView(),
  AppRoute.bottomNaveBar: (context) => const BottomAppBar(),
};
