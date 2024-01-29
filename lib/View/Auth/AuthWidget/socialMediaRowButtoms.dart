import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/SocialMediaButtom.dart';
import 'package:smart_tourism/View/Home/HomeView.dart';


class socialMediaRowButtoms extends StatelessWidget {
  const socialMediaRowButtoms({super.key});



  Future signInWithGoogle() async {
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
    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.offAll(const HomeView());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        children: [
          SocialMediaButton(
            IconName: IconButton(
                onPressed: () {
                  
                },
                icon:
                    const Icon(Icons.facebook, color: Colors.blue)),
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
                
                icon: const Icon(Icons.g_mobiledata_sharp, color: Colors.red)

                ),
          ),
        ],
      ),
    );
  }
}
