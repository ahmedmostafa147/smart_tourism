import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Auth/Login/login.dart';
import '../../Core/constants/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/BottomNavigationBar/bottom_navigation_bar.dart';

class MyCustomSplashScreen extends StatefulWidget {
  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen> with TickerProviderStateMixin {
  static const int animationDuration = 3000;

  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _animation = Tween<double>(begin: 40, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastLinearToSlowEaseIn),
    );

    _controller.forward();

    _initializeTimers();
  }

  void _initializeTimers() {
    Timer(const Duration(seconds: 2), _updateFontSize);
    Timer(const Duration(seconds: 2), _updateContainerSize);
    Timer(const Duration(seconds: 3), _checkLoginStatus);
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      Get.off(() => NavBar());
    } else {
      Get.off(() => LoginView());
    }
  }

  void _updateFontSize() {
    setState(() {
      _fontSize = 1.06;
    });
  }

  void _updateContainerSize() {
    setState(() {
      _containerSize = 2;
      _containerOpacity = 1;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: animationDuration),
                curve: Curves.fastLinearToSlowEaseIn,
                height: height / _fontSize,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: _textOpacity,
                child: Text(
                  'SMART TOURISM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _animation.value,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: animationDuration),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: animationDuration),
                curve: Curves.fastLinearToSlowEaseIn,
                height: width / _containerSize,
                width: width / _containerSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Image.asset(Assets.imagesSplashViewImage),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 3000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: curvedAnimation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
