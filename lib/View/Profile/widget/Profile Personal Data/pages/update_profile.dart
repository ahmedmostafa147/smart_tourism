import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../Controller/Auth_controller/update_acc_controller.dart';
import '../../Profile%20Personal%20Data/pages/change_password.dart';
import '../../../../../widget/Custom%20Material%20Button/custom_material_button.dart';

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildSectionTitle('Personal Information'),
              SizedBox(height: 10.h),
              _buildTextField(
                controller: firstNameController,
                label: 'First Name',
                icon: Icons.person,
              ),
              SizedBox(height: 10.h),
              _buildTextField(
                controller: lastNameController,
                label: 'Last Name',
                icon: Icons.person_outline,
              ),
              SizedBox(height: 10.h),
              _buildTextField(
                controller: locationController,
                label: 'Location',
                icon: Icons.location_on,
              ),
              SizedBox(height: 20.h),
              CustomMaterialButton(
                buttonText: "Change Password",
                onPressed: () {
                  Get.to(ChangePasswordView());
                },
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () => updateUserProfile(),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  textStyle: TextStyle(fontSize: 18.sp),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text('Update Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
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
