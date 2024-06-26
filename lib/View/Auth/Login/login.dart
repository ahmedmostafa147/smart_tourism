import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Core/constants/font.dart';
import '../../../Controller/Auth_controller/login_controller.dart';
import '../Register/register.dart';
import '../Reset%20Password/reset_password.dart';

import '../AuthWidget/custom_button_auth.dart';
import '../AuthWidget/custom_logo_auth.dart';
import '../AuthWidget/text_form_field.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    String? validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }

      return null;
    }

    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      }

      return null;
    }

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => ListView(padding: EdgeInsetsDirectional.all(15.r), children: [
          Form(
            key: loginController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomLogoAuth(),
                    Text(
                      "Welcome To Smart Tourism".tr,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: TextFontStyle.Mano),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "LOGIN".tr,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  "Login To Continue Using Smart Tourism".tr,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextForm(
                      hintText: "Enter Your Email".tr,
                      controller: loginController.emailController,
                      labelText: "Email".tr,
                      validator: validateEmail,
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextForm(
                      hintText: "Enter Your Password".tr,
                      controller: loginController.passwordController,
                      labelText: "Password".tr,
                      validator: validatePassword,
                      isPassword: true,
                    ),
                    InkWell(
                      onTap: () async {
                        Get.to(() => ResetPasswordScreen());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        alignment: Alignment.topRight,
                        child: Text(
                          'Forgot your password ?'.tr,
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                    CustomButtonAuth(
                      title: loginController.isLoading.value
                          ? 'Loading...'.tr
                          : 'LOGIN'.tr,
                      onPressed: loginController.isLoading.value
                          ? null
                          : () async {
                              await loginController.loginWithEmail();
                            },
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                InkWell(
                  onTap: () async {
                    await Get.off(() => RegisterView());
                  },
                  child: const Center(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "Don't Have An Account ? ",
                      ),
                      TextSpan(
                          text: "Resister",
                          style: TextStyle(
                            color: Colors.teal,
                          )),
                    ])),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}
