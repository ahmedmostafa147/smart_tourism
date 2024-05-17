import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/registration_controller.dart';
import '../AuthWidget/custom_button_auth.dart';
import '../AuthWidget/custom_logo_auth.dart';
import '../Login/login.dart';
import '../AuthWidget/textformfield.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  final RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    String? validateFirstName(String? value) {
      if (value == null || value.isEmpty) {
        return 'First name is required';
      }
      // Add any additional validation rules here if needed
      return null;
    }

    String? validateLastName(String? value) {
      if (value == null || value.isEmpty) {
        return 'Last name is required';
      }
      // Add any additional validation rules here if needed
      return null;
    }

    String? validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
      if (value.length < 8) {
        return 'Password must be at least 8 characters long';
      }
      if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
        return 'Password must contain at least one letter';
      }
      if (!RegExp(r'[0-9]').hasMatch(value)) {
        return 'Password must contain at least one number';
      }
      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
        return 'Password must contain at least one special character';
      }

      return null;
    }

    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Invalid email format';
      }
      List<String> domains = [
        '@gmail.com',
        '@yahoo.com',
        '@hotmail.com',
        '@outlook.com',
        'mail.com',
        '@aol.com',
        '@zoho.com',
        '@yandex.com',
        '@icloud.com',
        '@gmx.com',
        '@mail.com',
        '@inbox.com'
      ];

      if (domains.any((domain) => value.endsWith(domain))) {
        return 'This domain is not allowed';
      }
      return null;
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Obx(
          () => Form(
            key: registrationController.formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomLogoAuth(),
                      Container(height: 20.h),
                      Center(
                        child: Text(
                          "Welcome To Smart Tourism",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Play",
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "REGISTER",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Container(height: 10.h),
                      const Text(
                        "Register To Continue Using Smart Tourism",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 15.h),
                      CustomTextForm(
                        hintText: "Enter Your First Name",
                        controller: registrationController.first,
                        labelText: "First Name",
                        validator: validateFirstName,
                        isPassword: false,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextForm(
                        hintText: "Enter Your Last Name",
                        controller: registrationController.last,
                        labelText: "Last Name",
                        validator: validateLastName,
                        isPassword: false,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextForm(
                        hintText: "Enter Your Email",
                        controller: registrationController.email,
                        labelText: "Email",
                        validator: validateEmail,
                        isPassword: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextForm(
                        hintText: "Enter Your Password",
                        controller: registrationController.password,
                        labelText: "Password",
                        validator: validatePassword,
                        isPassword: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                  CustomButtonAuth(
                    title: registrationController.isLoading.value
                        ? 'Loading...'
                        : 'Register',
                    onPressed: registrationController.isLoading.value
                        ? null
                        : () async {
                            await registrationController.registerWithEmail();
                          },
                  ),
                  Container(height: 10.h),
                  InkWell(
                    onTap: () {
                      Get.off(() => LoginView());
                    },
                    child: const Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Have An Account ? "),
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
