import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/custom_button_auth.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/text_form_field.dart';
import '../../../Controller/Auth_controller/reset_password.dart';

class ResetPasswordScreen extends StatelessWidget {
  final ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reset Password'),
        ),
        body: SafeArea(
          child: Form(
            key: resetPasswordController.formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextForm(
                        hintText: "Email",
                        controller: resetPasswordController.Email,
                        labelText: "Email",
                        isPassword: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            resetPasswordController.validateEmail(value),
                      ),
                      SizedBox(height: 20.0.h),
                      Obx(
                        () =>
                            resetPasswordController.emailError.value.isNotEmpty
                                ? Text(
                                    resetPasswordController.emailError.value,
                                    style: TextStyle(color: Colors.red),
                                  )
                                : SizedBox.shrink(),
                      ),
                      SizedBox(height: 20.0.h),
                      CustomTextForm(
                          hintText: "New Password",
                          controller: resetPasswordController.NewPassword,
                          labelText: "New Password",
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) =>
                              resetPasswordController.validatePassword(value),
                          isPassword: true),
                      SizedBox(height: 20.0.h),
                      Obx(
                        () => resetPasswordController
                                .passwordError.value.isNotEmpty
                            ? Text(
                                resetPasswordController.passwordError.value,
                                style: TextStyle(color: Colors.red),
                              )
                            : SizedBox.shrink(),
                      ),
                      SizedBox(height: 20.0.h),
                      Obx(
                        () => CustomButtonAuth(
                          onPressed: () {
                            resetPasswordController.resetPassword(
                                resetPasswordController.Email.text.trim(),
                                resetPasswordController.NewPassword.text
                                    .trim());
                          },
                          title: resetPasswordController.isLoading.value
                              ? 'Loading...'.tr
                              : 'Reset Password'.tr,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
