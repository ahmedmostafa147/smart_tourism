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
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Obx(
            () => Form(
                key: registrationController.formKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: ListView(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomLogoAuth(),
                        Container(height: 20.h),
                        Center(
                          child: Text("Welcome To Smart Tourism",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Play")),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text("REGISTER",
                            style: TextStyle(
                                fontSize: 30.sp, fontWeight: FontWeight.w200)),
                        Container(height: 10.h),
                        const Text("Register To Continue Using Smart Tourism",
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextForm(
                          HintText: "ُEnter Your First Name",
                          myController: registrationController.first,
                          LabelText: "First Name ",
                          validator: "Please enter your first name",
                          isPassword: false,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextForm(
                          HintText: "ُEnter Your Last Name",
                          myController: registrationController.last,
                          LabelText: "Last Name",
                          validator: "Please enter your last name",
                          isPassword: false,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextForm(
                          HintText: "ُEnter Your Email",
                          myController: registrationController.email,
                          LabelText: "Email",
                          validator: 'Please enter a valid email address',
                          isPassword: false,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextForm(
                          HintText: "ُEnter Your Password",
                          myController: registrationController.password,
                          LabelText: "Password",
                          validator: 'Please enter your password!',
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextForm(
                          HintText: "ُEnter Your Location",
                          myController: registrationController.location,
                          LabelText: "Location",
                          validator: 'Please enter your location!',
                          isPassword: false,
                          keyboardType: TextInputType.streetAddress,
                        ),
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
                        child: Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "Have An Account ? ",
                          ),
                          TextSpan(
                              text: "Login",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold)),
                        ])),
                      ),
                    ),
                  ]),
                )),
          )),
    );
  }
}
