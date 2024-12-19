import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../utils/StudentDetails.dart';
import '../../../utils/commonFunction/common_image_picker.dart';
import '../../../utils/enum/ui_enum.dart';

class ProfileController extends GetxController {
  // DATA .
  RxString selectedProfilePickLink = ''.obs;
  RxBool isScolageUpdatesOn = true.obs;


  // IMAGE PICKER METHOD
  Future<void> picProfileImage() async {
    // PIC FILE AND GET FILE PATH
    String? pickedImagePath = await CommonImagePicker.picImageAndGetFilePath();
    // CROPPED IMAGE
    if (pickedImagePath != null) {
      CroppedFile? croppedImage =
          await CommonImagePicker.cropImage(pickedImagePath);
      selectedProfilePickLink.value = croppedImage?.path ?? '';
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
