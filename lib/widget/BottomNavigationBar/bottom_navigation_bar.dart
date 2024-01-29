import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_tourism/View/Home/HomeView.dart';

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
        const HomeView(),
        const HomeView(),
        const HomeView(),
        const HomeView(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          title: "Explore",
          icon: Icon(
            FontAwesomeIcons.house,
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
         PersistentBottomNavBarItem(
          title: "Favorite",
          icon: Icon(
            FontAwesomeIcons.heart,
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          title: "Search",
          icon: Icon(
            FontAwesomeIcons.magnifyingGlass,
          ),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          title: "Plan",
          icon: Icon(FontAwesomeIcons.list),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          title: "Account",
          icon: Icon(
            FontAwesomeIcons.solidCircleUser,
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
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInCirc,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
      ),
      navBarStyle: NavBarStyle.style8);
}
