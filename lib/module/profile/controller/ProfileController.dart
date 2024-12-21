import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/StudentDetails.dart';
import '../../../utils/commonFunction/common_image_picker.dart';
import '../../../utils/enum/ui_enum.dart';

class ProfileController extends GetxController {
  // DATA .
  RxString selectedProfilePickLink = ''.obs;
  RxBool isScolageUpdatesOn = true.obs;


  // IMAGE PICKER METHOD
  Future<void> picProfileImage() async {
    try {

      String? pickedImagePath = await CommonImagePicker.picImageAndGetFilePath();
      print("Picked image path: $pickedImagePath");
      if (pickedImagePath != null && pickedImagePath.isNotEmpty) {

        CroppedFile? croppedImage = await CommonImagePicker.cropImage(pickedImagePath);
        print("Cropped image path: ${croppedImage?.path}");
        if (croppedImage != null && croppedImage.path.isNotEmpty) {
          selectedProfilePickLink.value = croppedImage.path;
        } else {
          print("Cropped image is null or empty.");
        }
      } else {
        print("Picked image path is null or empty.");
      }
    } catch (e) {
      print("Error while picking or cropping image: $e");
      // Show error to user
    }
  }

  Future<void> saveProfileImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImagePath', path);
  }

  Future<void> loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    String? path = prefs.getString('profileImagePath');
    if (path != null && path.isNotEmpty) {
      selectedProfilePickLink.value = path;
    }
  }


  // PROFILE DETAIL AND EDIT DATA
  TextEditingController nameController = TextEditingController(text: StudentDetails.name);
  TextEditingController phoneNumberController = TextEditingController(text: "${StudentDetails.mobile}");
  TextEditingController emailController = TextEditingController(text: StudentDetails.email);
  Rx<DateTime?> dateOfBirth = DateTime(2002, 08, 02).obs;
  TextEditingController schoolNameController = TextEditingController(text: StudentDetails.schoolName);
  Rx<ParentsOrStudentEnum?> selectedRole = Rx(ParentsOrStudentEnum.student);


  @override
  void onInit() {
    // TODO: implement onInit
    nameController.addListener(() {
      StudentDetails.name = nameController.text;
      print('StudentDetails.name updated: ${StudentDetails.name}');
    });
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }
}
