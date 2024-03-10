import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/reset_password.dart';

class ResetPasswordScreen extends StatelessWidget {
  final ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());

  final TextEditingController _userIdentifierController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _userIdentifierController,
              decoration: InputDecoration(labelText: 'User Email'),
            ),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _resetPassword(),
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _resetPassword() {
    String userIdentifier = _userIdentifierController.text;
    String newPassword = _newPasswordController.text;
    resetPasswordController.resetPassword(userIdentifier, newPassword);
  }
}
