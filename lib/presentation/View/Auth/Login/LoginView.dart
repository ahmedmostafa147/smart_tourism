import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/presentation/View/Auth/Register/RegisterView.dart';
import 'package:smart_tourism/presentation/widget/custombuttonauth.dart';
import 'package:smart_tourism/presentation/widget/customlogoauth.dart';
import 'package:smart_tourism/presentation/widget/textformfield.dart';
import 'package:smart_tourism/presentation/widget/socialMediaRowButtoms.dart';
import 'package:smart_tourism/presentation/widget/SocialMediaButtom.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 50.h),
              const Center(
                child: CustomLogoAuth(),
              ),
              Text(
                "LOGIN",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w200),
              ),
              const Text("Login To Continue Using The App",
                  style: TextStyle(
                    color: Colors.grey,
                  )),
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
                    HintText: "ُEnter Your Email",
                    mycontroller: email,
                    LabelText: "Email",
                    validator: "please enter your email!",
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextForm(
                    HintText: "ُEnter Your Password",
                    mycontroller: email,
                    LabelText: "Password",
                    validator: "please enter your password!",
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.topRight,
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ))
                ],
              ),
              CustomButtonAuth(
                  title: "Login",
                  onPressed: () {
                    Get.to(const RegisterView());
                  }),
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
              const socialMediaRowButtoms(),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(TextSpan(children: [
                    const TextSpan(
                      text: "Don't Have An Account ? ",
                    ),
                    TextSpan(
                        text: "Register",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp)),
                  ])),
                ],
              )
            ],
          ),
        ]),
      ),
    ));
  }
}
