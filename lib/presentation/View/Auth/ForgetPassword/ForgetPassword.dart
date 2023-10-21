import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/presentation/View/HomeView.dart';

class ForgetPasswordView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               Get.to(HomeView());
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
