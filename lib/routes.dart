import 'package:flutter/material.dart';
import 'View/Auth/Register/register.dart';
import 'View/Plan/plan.dart';
import 'View/Profile/profile.dart';
import 'View/Profile/widget/Logout/logout.dart';
import 'View/Search/Search.dart';
import 'View/Survey/survey.dart';
import 'widget/BottomNavigationBar/bottom_navigation_bar.dart';
import 'View/Auth/Login/login.dart';
import 'View/Home/home.dart';
import 'View/Location/location_view.dart';
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
  static const String location = "/location";
}

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.splash: (context) => MyCustomSplashScreen(),
  AppRoute.login: (context) => LoginView(),
  AppRoute.register: (context) => RegisterView(),
  AppRoute.home: (context) => const HomeView(),
  AppRoute.bottomNaveBar: (context) => const NavBar(),
  AppRoute.profile: (context) => Profile(),
  AppRoute.search: (context) => SearchScreen(),
  AppRoute.plan: (context) => Plan(),
  AppRoute.survey: (context) => Survey(),
  AppRoute.logout: (context) => Logout(),
  AppRoute.location: (context) => LocationView(), 
};
