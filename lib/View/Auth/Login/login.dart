import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/login_controller.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/scoial_media_row_button.dart';
import 'package:smart_tourism/View/Auth/Register/register.dart';

import '../AuthWidget/custom_button_auth.dart';
import '../AuthWidget/custom_logo_auth.dart';
import '../AuthWidget/textformfield.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            Form(
              key: loginController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 50.h),
                  const Center(
                    child: CustomLogoAuth(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Text(
                      "Welcome To Smart Tourism".tr,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Play",
                      ),
                    ),
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
                        HintText: "Enter Your Email".tr,
                        myController: loginController.emailController,
                        LabelText: "Email".tr,
                        validator: "Please enter your email!".tr,
                        isPassword: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextForm(
                        HintText: "Enter Your Password".tr,
                        myController: loginController.passwordController,
                        LabelText: "Password".tr,
                        validator: "Please enter your password!".tr,
                        isPassword: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      InkWell(
                        onTap: () async {},
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 20),
                          alignment: Alignment.topRight,
                          child: Text(
                            'Forgot your password?'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
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
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(),
                      ),
                      SizedBox(width: 10.w),
                      const Text("OR LOGIN with",
                          style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 10.w),
                      const Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  socialMediaRowButtoms(),
                  SizedBox(height: 30.h),
                  InkWell(
                    onTap: () {
                      Get.off(() => RegisterView());
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
      ),
    ));
  }
}
