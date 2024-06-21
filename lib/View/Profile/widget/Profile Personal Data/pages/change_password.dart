import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/text_form_field.dart';
import 'package:smart_tourism/widget/Custom%20Material%20Button/custom_material_button.dart';
import '../../../../../Controller/Auth_controller/change_password_controller.dart';

class ChangePasswordView extends StatelessWidget {
  final ChangePasswordController _controller =
      Get.put(ChangePasswordController());

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            CustomTextForm(
              hintText: 'Current Password',
              controller: _currentPasswordController,
              labelText: 'Current Password',
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your current password';
                }
                return null;
              },
              icon: Icons.lock,
              isPassword: true,
            ),
            SizedBox(height: 20.h),
            CustomTextForm(
              hintText: 'New Password',
              controller: _newPasswordController,
              labelText: 'New Password',
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your new password';
                }
                return null;
              },
              icon: Icons.lock,
              isPassword: true,
            ),
            SizedBox(height: 20.h),
            CustomMaterialButton(
              buttonText: 'Change Password',
              onPressed: () {
                _controller.changePassword(
                  _currentPasswordController.text,
                  _newPasswordController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
