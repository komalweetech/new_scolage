// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:new_scolage/module/auth/controller/AuthController.dart';
import 'package:new_scolage/module/profile/view/screen/pandding_colleges.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/StudentDetails.dart';
import '../../../../utils/apiData/api_base_port.dart';
import '../../../../utils/commonFunction/common_function.dart';
import '../../../../utils/commonWidget/common_screen_content_title.dart';
import '../../../../utils/commonWidget/common_sub_screen_app_bar.dart';
import '../../../../utils/commonWidget/common_vertical_divider.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../auth/services/databaseHelper.dart';
import '../../controller/ProfileController.dart';
import '../../dependencies/profile_dependencies.dart';
import '../widget/common_colored_radius_button.dart';
import 'application_form.dart';
import 'applied_colleges.dart';
import 'approved_rejected_clg.dart';
import 'drower_review_screen.dart';
import 'edit_profile_screen.dart';
import 'package:http/http.dart' as http;

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  final ProfileController profileController = ProfileController();
  final AuthController authController = Get.find();


  @override
  void initState() {
    super.initState();
    print("student id in profile screen = ${StudentDetails.studentId}");
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

  void navigateToEditProfile(BuildContext context) async {
    Map<String,String> userData = await fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonSubScreenAppBar(title: ""),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonScreenContentTitle(title: "Profile"),
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 10.h,
                top: 16,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      await kProfileController.picProfileImage();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Stack(
                      children: [
                        Container(
                          height: 70.h,
                          width: 70.h,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Obx(
                                () {
                              if (kProfileController.selectedProfilePickLink.value.isNotEmpty) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(
                                    File(kProfileController.selectedProfilePickLink.value),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return Icon(Icons.person, size: 70, color: Colors.grey);
                              }
                            },
                          )
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 24.h,
                            width: 24.h,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(128, 128, 128, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.edit,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StudentDetails.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "+91 ${StudentDetails.mobile}",
                          style: TextStyle(
                              color: Color.fromRGBO(128, 128, 128, 1),
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  // EDIT BUTTON
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: () async {
                        CommonFunction.kNavigatorPush(
                          context,
                          EditProfileWidget(),
                        );
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.h),
            CommonDivider(),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MY DATA TITLE .
                  Text(
                    "My Data",
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 20.h),
                  // APPLICATION FORM AND MY REVIEWS BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: CommonColoredRadiusButton(
                          color: Color.fromRGBO(255, 214, 0, 1),
                          onTap: () {
                            CommonFunction.kNavigatorPush(
                                context, ApplicationForm());
                          },
                          title: "Application Form",
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Expanded(
                        child: CommonColoredRadiusButton(
                          color: Color.fromRGBO(255, 214, 0, 1),
                          onTap: () {
                            Get.to(DrawerReviewScreen(
                                studentId: StudentDetails.studentId));
                            print(
                                "drower student id == ${StudentDetails.studentId}");
                          },
                          title: "My Reviews",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  // COLLEGE SELECTION TITLE
                  Text(
                    "College Selection",
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 20.h),
                  // APPLIED COLLEGES AND PENDING COLLEGES BUTTON
                  Row(
                    children: [
                      Expanded(
                        child: CommonColoredRadiusButton(
                          color: Color.fromRGBO(175, 222, 239, 1),
                          onTap: () {
                            Get.to(AppliedColleges());
                          },
                          title: "Applied colleges",
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Expanded(
                        child: CommonColoredRadiusButton(
                          color: Color.fromRGBO(175, 222, 239, 1),
                          onTap: () {
                            Get.to(PanddingColleges());
                          },
                          title: "Pending colleges",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // APPROVED & REJECTED BUTTON
                  Row(
                    children: [
                      Expanded(
                        child: CommonColoredRadiusButton(
                          color: Color.fromRGBO(175, 222, 239, 1),
                          onTap: () {
                            Get.to(ApprovedRejectedClg());
                          },
                          title: "Approved & Rejected",
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  SizedBox(height: 60.h),
                  // WHATSAPP BUTTON
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Get Scolage updates on WhatsApp",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700),
                        ),
                      )),
                      CupertinoSwitch(
                          activeColor: kPrimaryColor,
                          trackColor: Colors.grey.withOpacity(0.5),
                          value: false,
                          onChanged: (value) {
                            profileController.isScolageUpdatesOn.value = value;
                          }),
                      SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
