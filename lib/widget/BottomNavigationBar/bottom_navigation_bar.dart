import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:smart_tourism/View/Search/home_search.dart';
import 'package:smart_tourism/View/Search/result_search.dart';
import '../../View/Favorite/favorite.dart';
import '../../View/Profile/Information Screen.dart';
import '../../View/Home/home.dart';
import '../../View/Plan/plan.dart';
import '../../Core/constants/images.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() => [
        const HomeView(),
        HomeSearchScreen(),
        Plan(),
        FavoritesScreen(),
        Profile(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          textStyle: TextStyle(
              fontSize: 12.sp, fontFamily: "Mano", fontWeight: FontWeight.w600),
          title: "Discover".tr,
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
          title: "Search".tr,
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
          title: "Plan".tr,
          icon: ImageIcon(
            AssetImage(Assets.imagesBusiness),
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          textStyle: TextStyle(
              fontSize: 12.sp, fontFamily: "Mano", fontWeight: FontWeight.w600),
          title: "Favorites".tr,
          icon: ImageIcon(
            AssetImage(Assets.imagesSquareHeart),
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          textStyle: TextStyle(
              fontSize: 12.sp, fontFamily: "Mano", fontWeight: FontWeight.w600),
          title: "Account".tr,
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
      ),
      navBarStyle: NavBarStyle.style9);
}
