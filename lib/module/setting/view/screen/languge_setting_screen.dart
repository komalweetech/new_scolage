// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_scolage/module/dashboard/view/screen/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/StudentDetails.dart';
import '../../../../utils/apiData/api_base_port.dart';
import '../../../../utils/commonFunction/common_bottom_sheet_function.dart';
import '../../../../utils/commonWidget/common_loading_dialog.dart';
import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/commonWidget/common_screen_content_title.dart';
import '../../../../utils/commonWidget/common_sub_screen_app_bar.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../auth/controller/AuthController.dart';
import '../../../auth/services/databaseHelper.dart';
import '../../../auth/view/screen/login_screen.dart';
import '../../dependencies/setting_dependencies.dart';
import '../widget/select_language_bottom_sheet.dart';

class LanguageSettingScreen extends StatelessWidget {
  const LanguageSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: const CommonSubScreenAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const CommonScreenContentTitle(title: "Change Language"),
          // SizedBox(height: 70..h),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20.w),
          //   child: Obx(
          //     () => TextFormField(
          //       readOnly: true,
          //       onTap: () async {
          //         // BOTTOM SHEET
          //         await commonBottomSheetFunction(
          //           context: context,
          //           child: const SelectLanguageBottomSheet(),
          //         );
          //       },
          //       controller: TextEditingController(
          //         text: kSettingController.selectedLanguage.value.displayName,
          //       ),
          //       decoration: InputDecoration(
          //         isDense: true,
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(8),
          //             borderSide: const BorderSide(color: Colors.black)),
          //         contentPadding:
          //             EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          //         suffixIcon: const Icon(
          //           Icons.keyboard_arrow_down_rounded,
          //           color: Color.fromRGBO(77, 77, 77, 1),
          //           size: 30,
          //         ),
          //         labelText: "Language",
          //         alignLabelWithHint: true,
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 30),
          // CommonSaveAndSubmitButton(
          //   name: "Save",
          //   onTap: () {
          //     Navigator.pop(context);
          //     },
          // ),
          SizedBox(height: 30),
          CommonSaveAndSubmitButton(
            name: "Log out",
            onTap: () async {
              try {
                CommonLoadingDialog.showLoadingDialog();
                Fluttertoast.showToast(
                  msg: "Logged out successfully!",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: kPrimaryColor,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                Get.offAll(() => const LoginScreen());
              } catch (e) {
                Fluttertoast.showToast(
                  msg: "Error during logout: $e",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              } finally {
                CommonLoadingDialog.cancelDialog();
              }
            },
          ),
          SizedBox(height: 30),
          CommonSaveAndSubmitButton(
            name: "Delete User",
            onTap: () async {
              bool confirmDelete = await Get.defaultDialog(
                title: "Confirm Delete",
                middleText: "Are you sure you want to delete this user?",
                textConfirm: "Yes",
                textCancel: "No",
                confirmTextColor: Colors.white,
                onConfirm: () => Get.back(result: true),
                onCancel: () => Get.back(result: false),
              );

              if (!confirmDelete) return;

              try {
                CommonLoadingDialog.showLoadingDialog();

                String studentId = StudentDetails.studentId;
                print("delete api = $studentId");
                var response = await http.delete(
                  Uri.parse("http://192.168.29.127:7000/v2/delete/student/$studentId"),
                  headers: {
                    "Content-Type": "application/json",
                  },
                );
                print("delete api response == ${response.body}");

                if (response.statusCode == 200) {
                  Fluttertoast.showToast(
                    msg: "User deleted successfully!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );

                  // Clear local storage (SharedPreferences or SQL)
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.clear();

                  // Navigate to Home Screen
                  Get.offAll(() => const DashboardScreen());
                } else {
                  print("delete status code == ${response.statusCode}");
                  Fluttertoast.showToast(
                    msg: "Failed to delete user. Try again later.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              } catch (e) {
                Fluttertoast.showToast(
                  msg: "Error during delete: $e",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              } finally {
                CommonLoadingDialog.cancelDialog();
              }
            },
          ),

        ],
      ),
    );
  }
}
