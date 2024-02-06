import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'social_media_button.dart';
import '../../Home/home.dart';
import '../../Survey/survey.dart';
import '../../../widget/BottomNavigationBar/bottom_navigation_bar.dart';

class socialMediaRowButtoms extends StatelessWidget {
  const socialMediaRowButtoms({super.key});

  Future signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user is new
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        // User is new, you can navigate to the survey page or perform any other actions
        // For example, you can use Get.off or Navigator.pushReplacement to navigate to a new page.
        Get.offAll(Survey());
      } else {
        // User is not new, navigate to the home page
        Get.offAll(const BottomNavBar());
      }
    } catch (e) {
      // Handle errors
      print('Error signing in with Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        children: [
          SocialMediaButton(
            IconName: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.facebook, color: Colors.blue)),
          ),
          const Spacer(),
          SocialMediaButton(
            IconName: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.apple, color: Colors.black)),
          ),
          const Spacer(),
          SocialMediaButton(
            IconName: IconButton(
                onPressed: () {
                  signInWithGoogle();
                },
                icon: const Icon(Icons.g_mobiledata_sharp, color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
