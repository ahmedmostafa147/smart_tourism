import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../View/Profile/profile.dart';
import '../../View/Plan/model.dart';
import '../../View/Lang/lang.dart';
import '../../View/Favorite/favorite.dart';
import '../../View/Home/home.dart';
import '../../View/Plan/plan.dart';

import '../../View/Search/Search.dart';
import '../../View/Survey/survey.dart';
import '../../constants/images.dart';

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
        SearchScreen(),
        Plan(),
         Survey(),
        Profile(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          textStyle: TextStyle(
              fontSize: 12.sp, fontFamily: "Mano", fontWeight: FontWeight.w600),
          title: "Discover",
          icon: ImageIcon(
            AssetImage(
              Assets.imagesHouseBlank,
            ),
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          textStyle: TextStyle(
              fontSize: 12.sp, fontFamily: "Mano", fontWeight: FontWeight.w600),
          title: "Search",
          icon: ImageIcon(
            AssetImage(
              Assets.imagesSearch,
            ),
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          textStyle: TextStyle(
              fontSize: 12.sp, fontFamily: "Mano", fontWeight: FontWeight.w600),
          title: "Plan",
          iconSize: 29.r,
          icon: ImageIcon(
            AssetImage(
              Assets.imagesBusinessPlan,
            ),
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          textStyle: TextStyle(
              fontSize: 12.sp, fontFamily: "Mano", fontWeight: FontWeight.w600),
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
          textStyle: TextStyle(
              fontSize: 12.sp, fontFamily: "Mano", fontWeight: FontWeight.w600),
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
      bottomScreenMargin: 60.h,
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
