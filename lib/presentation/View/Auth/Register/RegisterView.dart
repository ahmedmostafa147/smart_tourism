import 'package:flutter/material.dart';
import 'package:smart_tourism/presentation/widget/custombuttonauth.dart';
import 'package:smart_tourism/presentation/widget/customlogoauth.dart';
import 'package:smart_tourism/presentation/widget/textformfield.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
 TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

 return SafeArea(
   child: Scaffold(
     resizeToAvoidBottomInset: true,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 50),
                const CustomLogoAuth(),
                Container(height: 20),
                const Text("SignUp",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Container(height: 10),
                const Text("SignUp To Continue Using The App",
                    style: TextStyle(color: Colors.grey)),
                Container(height: 20),
                
                Container(height: 10),
                CustomTextForm(
                    HintText: "ُEnter Your username", mycontroller: username,LabelText: "username",validator: "please enter username",),
                Container(height: 20),
               
                Container(height: 10),
                CustomTextForm(
                    HintText: "ُEnter Your Email", mycontroller: email,LabelText: "Email",validator: 'Please enter your email!',),
                Container(height: 10),
               
                Container(height: 10),
                CustomTextForm(
                    HintText: "ُEnter Your Password", mycontroller: email,LabelText: "Password",validator: 'Please enter your password!',),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  alignment: Alignment.topRight,
                  child: const Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            CustomButtonAuth(title: "SignUp", onPressed: () {}),
            Container(height: 20),
 
            Container(height: 20),
            // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
            InkWell(
              onTap: () {
               
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Have An Account ? ",
                  ),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                ])),
              ),
            )
          ]),
        ),
      ),
 );
  }
  }
