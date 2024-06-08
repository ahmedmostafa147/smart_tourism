import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../Controller/Auth_controller/google_auth_controller.dart';

class GoogleLogin extends StatefulWidget {
  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  final GoogleSignInController _controller = Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.redAccent)),
      width: double.infinity,
      child: Column(
        children: [
          Center(
            child: Obx(() {
              final user = _controller.currentUser.value;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (user != null)
                    ListTile(
                      leading: GoogleUserCircleAvatar(identity: user),
                      title: Text(user.displayName ?? ''),
                      subtitle: Text(user.email),
                    )
                  else
                    Text('You are not signed in.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        user != null ? _controller.signOut : _controller.signIn,
                    child: Text(user != null ? 'SIGN OUT' : 'SIGN IN'),
                  ),
                  const SizedBox(height: 16),
                  Obx(() => Text(_controller.contactText.value)),
                ],
              );
            }),
          ),
          MaterialButton(
            elevation: 4,
            height: 40.h,
            minWidth: double.infinity,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () async {},
            child: Text(
              "Google",
              style: TextStyle(color: Colors.redAccent, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
