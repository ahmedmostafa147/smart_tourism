import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Login/login.dart';

class DeleteAccountButton extends StatefulWidget {
  const DeleteAccountButton({Key? key}) : super(key: key);

  @override
  _DeleteAccountButtonState createState() => _DeleteAccountButtonState();
}

class _DeleteAccountButtonState extends State<DeleteAccountButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
       
        Get.offAll(LoginView());
      },
      child: Text('Delete'),
    );
  }
}
