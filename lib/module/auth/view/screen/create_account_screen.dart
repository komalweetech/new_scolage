// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/commonWidget/common_screen_content_title.dart';
import '../../../../utils/commonWidget/common_sub_screen_app_bar.dart';
import '../../../../utils/commonWidget/keyboard_off.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../dashboard/view/screen/dashboard_screen.dart';
import '../widget/common_create_account_drop_down.dart';
import '../widget/create_account_text_field.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  final List<String> roleList = [
    'Student',
    'Parents',
  ];

  final List<String> genderList = [
    'Male',
    'Female',
  ];

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return KeyBoardOff(
      child: Scaffold(
        appBar: const CommonSubScreenAppBar(),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(height: 20.h),
            const CommonScreenContentTitle(
              padding: EdgeInsets.zero,
              title: "Finish creating account",
            ),
            SizedBox(height: 12.h),
            CommonCreateAccountDropDown(
              // labelText: "Role",
              hintText: "Select your role",
              onChanged: (value) {},
              values: roleList,
            ),
            CreateAccountTextField(
              controller: TextEditingController(),
              // labelText: "Name",
              hintText: "Enter Full Name",
            ),
            CommonCreateAccountDropDown(
              // labelText: "Gender",
              hintText: "Select your gender",
              onChanged: (value) {},
              values: genderList,
            ),
            CreateAccountTextField(
              controller: TextEditingController(),
              // labelText: "School Name",
              hintText: "Enter School Name",
            ),
            CreateAccountTextField(
              controller: TextEditingController(),
              // labelText: "Pass Code",
              hintText: "Enter Pass Code",
            ),
            CreateAccountTextField(
              controller: TextEditingController(),
              // labelText: "Re-Enter Pass Code",
              hintText: "Re-Enter Pass Code",
            ),
            CreateAccountTextField(
              controller: TextEditingController(),
              // labelText: "Mobile Number",
              hintText: "Enter Mobile Number",
            ),
            CreateAccountTextField(
              controller: TextEditingController(),
              // labelText: "Email Address",
              hintText: "Enter Email Address",
            ),
            SizedBox(height: 20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.black,
                ),
                Expanded(
                  child: Text(
                    "I would like to receive marketing offers and promotional communications from scolage.",
                    style: TextStyle(
                      color: grey128Color,
                      fontSize: 14.sp,

                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.black,
                ),
                Expanded(
                  child: Text(
                    "By creating an account or signing in you agree with our terms and conditions.",
                    style: TextStyle(
                      color: grey128Color,
                      fontSize: 14.sp,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 8.h),
            CommonSaveAndSubmitButton(
              padding: EdgeInsets.zero,
              name: "Continue",
              onTap: () async {
                await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(),
                    ), (t) {
                  return false;
                });
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
