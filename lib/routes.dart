import 'package:flutter/material.dart';
import 'package:smart_tourism/View/Hotel/hotel.dart';
import 'package:smart_tourism/View/Places/places.dart';
import 'package:smart_tourism/View/Plan/user_plan.dart';
import 'package:smart_tourism/View/Profile/widget/Profile%20Personal%20Data/profile_page.dart';
import 'package:smart_tourism/View/Restaurant/restaurant.dart';
import 'package:smart_tourism/View/Search/result_search.dart';
import 'package:smart_tourism/View/Survey/result_survey.dart';
import 'package:smart_tourism/View/TODO/todo.dart';
import 'package:smart_tourism/View/TODO/todo_home.dart';
import 'package:smart_tourism/View/chat/chat.dart';
import 'View/Auth/Register/register.dart';
import 'View/Plan/plan.dart';
import 'View/Profile/Information Screen.dart';
import 'View/Profile/widget/Logout/logout.dart';
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
  static const String chat = "/ResultSearch";
  static const String location = "/location";
  static const String ProfilePage = "/ProfilePage";
  static const String ChatScreen = "/ChatScreen";
  static const String ResultSearch = "/ResultSurvey";
  static const String RandomPlacesScreen = "/RandomPlacesScreen";
  static const String RandomRestaurantsScreen = "/RandomRestaurantsScreen";
  static const String RandomHotelsScreen = "/RandomHotelsScreen";
  static const String LocalPlanScreen = "/ LocalPlanScreen";
  static const String AddToDoScreen = "/ AddToDoScreen";
  static const String TodoHome = "/ TodoHome";
}

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.splash: (context) => MyCustomSplashScreen(),
  AppRoute.login: (context) => LoginView(),
  AppRoute.register: (context) => RegisterView(),
  AppRoute.home: (context) => const HomeView(),
  AppRoute.bottomNaveBar: (context) => const NavBar(),
  AppRoute.profile: (context) => Profile(),
  AppRoute.search: (context) => ResultSearch(),
  AppRoute.plan: (context) => Plan(),
  AppRoute.survey: (context) => Survey(),
  AppRoute.logout: (context) => Logout(),
  AppRoute.location: (context) => LocationView(),
  AppRoute.ProfilePage: (context) => ProfilePage(),
  AppRoute.ChatScreen: (context) => ChatScreen(),
  AppRoute.ResultSearch: (context) => ResultSurvey(),
  AppRoute.RandomPlacesScreen: (context) => RandomPlacesScreen(),
  AppRoute.RandomRestaurantsScreen: (context) => RandomRestaurantsScreen(),
  AppRoute.RandomHotelsScreen: (context) => RandomHotelsScreen(),
  AppRoute.LocalPlanScreen: (context) => LocalPlanScreen(),
  AppRoute.AddToDoScreen: (context) => AddToDoScreen(),
  AppRoute.TodoHome: (context) => TodoHome(),
};
