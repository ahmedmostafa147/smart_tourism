import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/text_form_field.dart';
import '../../../Controller/location_controller.dart';
import '../../../Controller/Auth_controller/registration_controller.dart';
import '../AuthWidget/custom_button_auth.dart';
import '../AuthWidget/custom_logo_auth.dart';
import '../Login/login.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  final LocationController locationController = Get.put(LocationController());
  final RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: registrationController.formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomLogoAuth(),
                    SizedBox(height: 15.h),
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
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    const Text(
                      "Register To Continue Using Smart Tourism",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 15.h),
                    CustomTextForm(
                      hintText: "Enter Your First Name",
                      controller: registrationController.first,
                      labelText: "First Name",
                      validator: (value) =>
                          registrationController.validateFirstName(value),
                      isPassword: false,
                      keyboardType: TextInputType.name,
                    ),
                    Obx(
                      () =>
                          registrationController.firstNameError.value.isNotEmpty
                              ? Text(
                                  registrationController.firstNameError.value,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox.shrink(),
                    ),
                    SizedBox(height: 15.h),
                    CustomTextForm(
                      hintText: "Enter Your Last Name",
                      controller: registrationController.last,
                      labelText: "Last Name",
                      validator: (value) =>
                          registrationController.validateLastName(value),
                      isPassword: false,
                      keyboardType: TextInputType.name,
                    ),
                    Obx(
                      () =>
                          registrationController.lastNameError.value.isNotEmpty
                              ? Text(
                                  registrationController.lastNameError.value,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox.shrink(),
                    ),
                    SizedBox(height: 15.h),
                    CustomTextForm(
                      hintText: "Enter Your Email",
                      controller: registrationController.email,
                      labelText: "Email",
                      validator: (value) =>
                          registrationController.validateEmail(value),
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Obx(
                      () => registrationController.emailError.value.isNotEmpty
                          ? Text(
                              registrationController.emailError.value,
                              style: TextStyle(color: Colors.red),
                            )
                          : SizedBox.shrink(),
                    ),
                    SizedBox(height: 15.h),
                    CustomTextForm(
                      hintText: "Enter Your Password",
                      controller: registrationController.password,
                      labelText: "Password",
                      validator: (value) =>
                          registrationController.validatePassword(value),
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    Obx(
                      () =>
                          registrationController.passwordError.value.isNotEmpty
                              ? Text(
                                  registrationController.passwordError.value,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox.shrink(),
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      height: 50.h,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          locationController.getCurrentLocation();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.share_location_outlined),
                            SizedBox(
                              width: 5.w,
                            ),
                            Obx(() {
                              return locationController.isLoading.value
                                  ? Text(
                                      'Loading...',
                                      style: TextStyle(fontSize: 16.sp),
                                    )
                                  : Text(
                                      locationController
                                              .addressCountry.value.isEmpty
                                          ? 'Tap to select your location'
                                          : locationController
                                              .addressCountry.value,
                                      style: TextStyle(fontSize: 16.sp),
                                    );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => CustomButtonAuth(
                    title: registrationController.isLoading.value
                        ? 'Loading...'
                        : 'Register',
                    onPressed: registrationController.isLoading.value
                        ? null
                        : () async {
                            if (locationController
                                .addressCountry.value.isEmpty) {
                              Get.snackbar(
                                "Error",
                                "Please select your location",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } else if (registrationController
                                .formKey.currentState!
                                .validate()) {
                              await registrationController.registerWithEmail();
                            }
                          },
                  ),
                ),
                SizedBox(height: 10.h),
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
    );
  }
}
