import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/update_acc_controller.dart';
import 'package:smart_tourism/View/Profile/widget/Profile%20Personal%20Data/pages/change_password.dart';
import 'package:smart_tourism/widget/Custom%20Material%20Button/custom_material_button.dart';

class UpdateUserProfileScreen extends StatelessWidget {
  final UpdateController updateController = Get.put(UpdateController());
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 20.h),
            CustomMaterialButton(
                buttonText: "Change Password",
                onPressed: () {
                  Get.to(ChangePasswordView());
                }),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => updateUserProfile(),
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void updateUserProfile() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String location = locationController.text;
    updateController.updateUserProfile(
      firstName: firstName,
      lastName: lastName,
      userLocation: location,
    );
  }
}
