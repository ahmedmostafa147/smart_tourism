import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/google_auth_controller.dart';

class GoogleLogin extends StatelessWidget {
  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.redAccent)),
      width: double.infinity,
      child: MaterialButton(
        elevation: 4,
        height: 40.h,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: _googleSignInController.signInWithGoogle,
        child: Text(
          "Google",
          style: TextStyle(color: Colors.redAccent, fontSize: 20),
        ),
      ),
    );
  }
}
