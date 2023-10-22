import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_tourism/presentation/View/Auth/AuthWidget/SocialMediaButtom.dart';
import 'package:smart_tourism/presentation/View/HomeView.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class socialMediaRowButtoms extends StatelessWidget {
  const socialMediaRowButtoms({super.key});

  Future signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    Get.offAll(const HomeView());
  }

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
                  signInWithFacebook();
                },
                icon:
                    const Icon(FontAwesomeIcons.facebook, color: Colors.blue)),
          ),
          const Spacer(),
          SocialMediaButton(
            IconName: IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.apple, color: Colors.black)),
          ),
          const Spacer(),
          SocialMediaButton(
            IconName: IconButton(
                onPressed: () {
                  signInWithGoogle();
                },
                icon: const Icon(FontAwesomeIcons.google, color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
