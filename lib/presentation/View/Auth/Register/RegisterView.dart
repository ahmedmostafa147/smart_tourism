import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/presentation/View/Auth/AuthWidget/custombuttonauth.dart';
import 'package:smart_tourism/presentation/View/Auth/AuthWidget/customlogoauth.dart';
import 'package:smart_tourism/presentation/View/Auth/Login/LoginView.dart';
import 'package:smart_tourism/presentation/View/HomeView.dart';
import 'package:smart_tourism/presentation/View/Auth/AuthWidget/textformfield.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> fromkey = GlobalKey<FormState>();
    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: fromkey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 50.h),
                  const CustomLogoAuth(),
                  Container(height: 20.h),
                  Center(
                    child: Text("Welcome To Smart Tourism",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w400,fontFamily: "Play")),
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
                    height: 20.h,
                  ),
                  CustomTextForm(
                    HintText: "ُEnter Your username",
                    mycontroller: username,
                    LabelText: "username",
                    validator: "please enter username",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextForm(
                    HintText: "ُEnter Your Email",
                    mycontroller: email,
                    LabelText: "Email",
                    validator: 'Please enter your email!',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextForm(
                    HintText: "ُEnter Your Password",
                    mycontroller: password,
                    LabelText: "Password",
                    validator: 'Please enter your password!',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
              CustomButtonAuth(
                  title: "Register",
                  onPressed: () async {
                    if (fromkey.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        Get.off(() => const HomeView());
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error ',
                            desc: 'The password provided is too weak.',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          )..show();
                        } else if (e.code == 'email-already-in-use') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error ',
                            desc: 'The account already exists for that email.',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          )..show();
                        }
                      } catch (e) {
                        (e);
                      }
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error ',
                        desc: 'Please enter your data.',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      )..show();
                    }
                  }),
              Container(height: 20),

              Container(height: 20),
              // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
              InkWell(
                onTap: () {
                  Get.to(() => const LoginView());
                },
                child: const Center(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "Have An Account ? ",
                    ),
                    TextSpan(
                        text: "Login",
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold)),
                  ])),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
