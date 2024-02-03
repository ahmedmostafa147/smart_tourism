import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_tourism/View/Favorite/favorite.dart';
import 'package:smart_tourism/View/Home/home.dart';
import 'package:smart_tourism/View/Plan/plan.dart';
import 'package:smart_tourism/View/Profile/pages/profile_page.dart';
import 'package:smart_tourism/View/Search/Search.dart';
import 'package:smart_tourism/View/Survey/survey.dart';
import 'package:smart_tourism/constants/ImagesForFullApp.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() => [
        const HomeView(),
        const ListFavoritePlaces(),
        SearchScreen(),
        const Plan(),
        const ProfilePage(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [

        PersistentBottomNavBarItem(
         
          title: "Explore",
          icon: ImageIcon(
            AssetImage(
              Assets.imagesHouseBlank,
            ),
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          title: "Favorite",
          icon: ImageIcon(
            AssetImage(
              Assets.imagesSquareHeart,
            ),
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          title: "Search",
          icon: ImageIcon(
            AssetImage(
              Assets.imagesHouseBlank,
            ),
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          title: "Plan",
          icon: ImageIcon(
            AssetImage(
              Assets.imagesHouseBlank,
            ),
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          title: "Account",
          icon: ImageIcon(
            AssetImage(
              Assets.imagesCircleUser,
            ),
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
      ];

  @override
  Widget build(BuildContext context) => PersistentTabView(context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarHeight: 60.h,
      bottomScreenMargin: 15.h,
      resizeToAvoidBottomInset: true,
      confineInSafeArea: true,
      popAllScreensOnTapOfSelectedTab: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
      ),
      navBarStyle: NavBarStyle.style9);
}
