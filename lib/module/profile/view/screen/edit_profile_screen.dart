// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/StudentDetails.dart';
import '../../../../utils/apiData/api_base_port.dart';
import '../../../../utils/commonFunction/common_bottom_sheet_function.dart';
import '../../../../utils/commonFunction/common_date_formater.dart';
import '../../../../utils/commonFunction/common_function.dart';
import '../../../../utils/commonWidget/common_datepicker.dart';
import '../../../../utils/commonWidget/common_screen_content_title.dart';
import '../../../../utils/commonWidget/common_sub_screen_app_bar.dart';
import '../../../../utils/commonWidget/keyboard_off.dart';
import '../../../../utils/theme/common_color.dart';
import '../../dependencies/profile_dependencies.dart';
import '../widget/edit_profile_text_field.dart';
import '../widget/select_role_bottom_sheet.dart';

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({super.key});


  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  void _showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: kPrimaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }


  Future<Map<String, String>> fetchUserData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiBasePort.apiBaseUrl}/v2/reg/student/${StudentDetails.studentId}'),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return {};
    }
  }
  @override
  Widget build(BuildContext context) {
    return KeyBoardOff(
      child: Scaffold(
        appBar: CommonSubScreenAppBar(
          actions: [
            Padding(
              padding:  EdgeInsets.only(right: 12),
              child: TextButton(
                onPressed: () async{
                  CommonFunction.keyboardOff(context);
                  Map<String,String>  data = {
                    "name" : kProfileController.nameController.text,
                    "email" : kProfileController.emailController.text,
                    "mobile" : kProfileController.phoneNumberController.text,
                    "school_name" : kProfileController.schoolNameController.text,
                    "dob" : CommonDateFormats.dtToDDMMYYYY(kProfileController.dateOfBirth.value ?? DateTime.now()),
                    "role" : kProfileController.selectedRole.value?.displayName ?? " ",
                  };
                  print("student id in edit Profile screen == ${StudentDetails.studentId}");
                  print("edit profile data List == $data");
                  try{
                      final response = await http.patch(
                          // Uri.parse('https://backend.scolage.com/v2/reg/student/edit/${StudentDetails.studentId}'),
                        Uri.parse('${ApiBasePort.apiBaseUrl}/v2/reg/student/edit/${StudentDetails.studentId}'),
                      body: jsonEncode(data),
                      headers: {'Content-Type': 'application/json'},
                    );
                      print("Response ====");
                    print(response.body);

                    if (response.statusCode == 200) {
                      Map<String, dynamic> map = jsonDecode(response.body);
                      print("edit data  == $map");
                      if (map["status"] == "success") {
                        _showSuccessToast("Profile Data Saved Successfully");
                        Navigator.pop(context,data);
                      } else {
                        _showErrorToast("Your Profile data not saved, something went wrong");
                      }
                    } else {
                      _showErrorToast("Failed to save profile data. Please try again.");
                      print('Error in PATCH request: ${response.statusCode}, ${response.body}');
                    }
                  } catch (error) {
                    _showErrorToast("Failed to save profile data. Please try again.");
                    print('Error in PATCH request: $error');
                  }
                  },
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Color.fromRGBO(96, 38, 158, 1),fontFamily: "Poppins",fontWeight: FontWeight.w500
                  ),
                ),
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            const CommonScreenContentTitle(title: "Profile"),
            SizedBox(height: 26.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal details",
                    style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 10),
                  // NAME FIELD
                  EditProfileTextField(
                    labelText: "Name",
                    controller: kProfileController.nameController,
                    textInputAction: TextInputAction.next,
                  ),
                  // PHONE NUMBER FIELD
                  EditProfileTextField(
                    labelText: "Phone No.",
                    controller: kProfileController.phoneNumberController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  // EMAIL ID FIELD
                  EditProfileTextField(
                    labelText: "Email address",
                    controller: kProfileController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  // DATE OF BIRTH FIELD
                  Obx(
                    () => EditProfileTextField(
                      textInputAction: TextInputAction.next,
                      labelText: "Date of birth",
                      readOnly: true,
                      onTap: () async {
                        kProfileController.dateOfBirth.value =
                            await CommonDatePicker.showCustomDatePicker(
                                    context: context,
                                    initialDate:
                                        kProfileController.dateOfBirth.value ??
                                            DateTime.now()) ??
                                DateTime.now();
                      },
                      controller: TextEditingController(
                        text: CommonDateFormats.dtToDDMMYYYY(
                          kProfileController.dateOfBirth.value ??
                              DateTime.now(),

                        ),
                      ),
                    ),
                  ),
                  // SCHOOL FIELD
                  EditProfileTextField(
                    labelText: "School",
                    controller: kProfileController.schoolNameController,
                    textInputAction: TextInputAction.next,
                  ),
                  // PA RENTS OR STUDENT FIELD
                  Obx(
                    () => EditProfileTextField(
                      labelText: "Parent or Student",
                      readOnly: true,
                      onTap: () async {
                        // BOTTOM SHEET
                        await commonBottomSheetFunction(
                          context: context,
                          child: SelectRoleBottomSheet(),
                        );
                      },
                      controller: TextEditingController(
                        text: kProfileController.selectedRole.value?.displayName ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
