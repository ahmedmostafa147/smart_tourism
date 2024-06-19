import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Location/location_controller.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/text_form_field.dart';
import '../../../../../Controller/Auth_controller/update_acc_controller.dart';
import '../../Profile%20Personal%20Data/pages/change_password.dart';
import '../../../../../widget/Custom%20Material%20Button/custom_material_button.dart';

class UpdateUserProfileScreen extends StatelessWidget {
  final UpdateController updateController = Get.put(UpdateController());
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final LocationController locationController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text('Personal Information'),
                SizedBox(height: 20.h),
                CustomTextForm(
                    hintText: 'First Name',
                    controller: firstNameController,
                    labelText: 'First Name',
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      
                      return null;
                    },
                    icon: Icons.person,
                    isPassword: false),
                SizedBox(height: 20.h),
                CustomTextForm(
                    hintText: 'Last Name',
                    controller: lastNameController,
                    labelText: 'Last Name',
                    keyboardType: TextInputType.name,
                    icon: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    isPassword: false),
                SizedBox(height: 20.h),
                Container(
                  height: 45.h,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
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
                                      : locationController.addressCountry.value,
                                  style: TextStyle(fontSize: 16.sp),
                                );
                        }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                CustomMaterialButton(
                  buttonText: "Update",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateUserProfile();
                    }
                  },
                ),
                SizedBox(height: 20.h),
                CustomMaterialButton(
                  buttonText: "Change Password",
                  onPressed: () {
                    Get.to(ChangePasswordView());
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateUserProfile() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String location = locationController.addressCountry.value;
    updateController.updateUserProfile(
        firstName: firstName, lastName: lastName, userLocation: location);
  }
}
