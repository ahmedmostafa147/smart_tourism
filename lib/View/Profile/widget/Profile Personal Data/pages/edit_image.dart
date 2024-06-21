import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_tourism/Controller/Auth_controller/upload_profile_img.dart';

class EditImageProfile extends StatefulWidget {
  const EditImageProfile({super.key});

  @override
  State<EditImageProfile> createState() => _EditImageProfileState();
}

class _EditImageProfileState extends State<EditImageProfile> {
  final UploadProfilePhotoController userController =
      Get.put(UploadProfilePhotoController());

  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                width: 200,
                height: 200,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            if (_imageFile != null) Text('Selected Image: ${_imageFile!.path}'),
            ElevatedButton(
              onPressed: () {
                if (_imageFile != null) {
                  userController.uploadProfileImage(_imageFile!);
                } else {
                  Get.snackbar("Error", "Please pick an image first",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                      colorText: Colors.white);
                }
              },
              child: Obx(() {
                return userController.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Upload Image');
              }),
            ),
          ],
        ),
      ),
    );
  }
}
