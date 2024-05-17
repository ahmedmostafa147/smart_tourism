import 'package:flutter/material.dart';
import 'package:smart_tourism/View/Auth/Register/register.dart';
import 'package:smart_tourism/View/Plan/plan.dart';
import 'package:smart_tourism/View/Profile/profile.dart';
import 'package:smart_tourism/View/Profile/widget/Logout/logout.dart';
import 'package:smart_tourism/View/Search/Search.dart';
import 'package:smart_tourism/View/Survey/survey.dart';
import 'package:smart_tourism/widget/BottomNavigationBar/bottom_navigation_bar.dart';
import 'View/Auth/Login/login.dart';
import 'View/Home/home.dart';
import 'View/Splash/splash_screen.dart';

class AppRoute {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/home";
  static const String bottomNaveBar = "/bottomNavBar";
  static const String profile = "/profile";
  static const String settings = "/settings";
  static const String search = "/search";
  static const String plan = "/plan";
  static const String favorite = "/favorite";
  static const String survey = "/survey";
  static const String recommendation = "/recommendation";
  static const String placeDetails = "/placeDetails";
  static const String logout = "/logout";
  
}

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.splash: (context) => MyCustomSplashScreen(),
  AppRoute.login: (context) => LoginView(),
  AppRoute.register: (context) => RegisterView(),
  AppRoute.home: (context) => const HomeView(),
  AppRoute.bottomNaveBar: (context) => const NavBar(),
  AppRoute.profile: (context) =>  Profile(),
  AppRoute.search: (context) => SearchScreen(),
  AppRoute.plan: (context) => Plan(),
  AppRoute.survey: (context) => Survey(),
  AppRoute.logout: (context) => Logout(),
  
};
