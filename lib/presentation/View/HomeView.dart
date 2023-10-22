import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_tourism/presentation/View/Auth/Login/LoginView.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                GoogleSignIn googleSignIn = GoogleSignIn();
                await googleSignIn.signOut();
                FacebookAuth.instance.logOut();
                Get.offAll(() => const LoginView());
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Column(
          children: [
            Center(
                child: Text(
              "hello",
              style: TextStyle(fontSize: 100.sp),
            )),
          ],
        ),
      ),
    );
  }
}
