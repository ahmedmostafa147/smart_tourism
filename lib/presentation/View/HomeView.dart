import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/presentation/View/Auth/Login/LoginView.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
                child: Text(
              "hello",
              style: TextStyle(fontSize: 100.sp),
            )),
            ElevatedButton(
              onPressed: () {
                Get.to(const LoginView());
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
