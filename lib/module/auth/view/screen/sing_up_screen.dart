import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:new_scolage/module/auth/controller/AuthController.dart';
import '../../../../utils/StudentDetails.dart';
import '../../../../utils/apiData/api_base_port.dart';
import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/commonWidget/common_sq_text_button.dart';
import '../../../../utils/constant/asset_icons.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../utils/theme/common_color.dart';
import '../../services/databaseHelper.dart';
import '../widget/webViewPage.dart';
import 'login_screen.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final authController  = Get.put(AuthController());

  Map<String, TextEditingController> controllers = {
    'name': TextEditingController(),
    'gender': TextEditingController(),
    'schoolName': TextEditingController(),
    'password': TextEditingController(),
    'confirmPassword': TextEditingController(),
    'mobile': TextEditingController(),
    'email': TextEditingController(),
  };

  String? selectedGender;
  List<String> genderOptions = ['Male', 'Female', 'Other'];
  bool isSelected = false;
  bool agreedToTerms1 = false;
  bool agreedToTerms2 = false;
  bool obscureText = true;


  Future<void> _submitSingUpData() async {
    // Check if any of the fields are empty
    if (controllers['name']!.text.isEmpty  ||
        controllers['gender']!.text.isEmpty  ||
        controllers['schoolName']!.text.isEmpty ||
        controllers['password']!.text.isEmpty  ||
        controllers['confirmPassword']!.text.isEmpty  ||
        controllers['email']!.text.isEmpty ) {
      Fluttertoast.showToast(
        msg: "Please fill in all fields",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }


    String apiUrl = '${ApiBasePort.apiBaseUrl}/v2/reg/students';
    String? studentId = StudentDetails.studentId;
    print("student id in sign up screen == ===== $studentId}");


    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: controllers['email']!.text.trim(),
        password: controllers['password']!.text.trim(),
      );
      String uid = userCredential.user!.uid;

      Map<String, dynamic> userData = {
        'role': 'student',
        'name': controllers['name']?.text.trim(),
        'gender': controllers['gender']?.text.trim(),
        'school_name': controllers['schoolName']?.text.trim(),
        'password': controllers['password']?.text.trim(),
        'confirm_password':controllers['confirmPassword']?.text.trim(),
        'mobile': StudentDetails.mobile,
        'email': controllers['email']?.text.trim(),
        'isLoggedIn': 0,
      };

      var response = await http.post(Uri.parse(apiUrl),
        body: json.encode(userData ),
        headers: {'Content-Type': 'application/json'},
      );
      print("your details == $userData ");
      print("Response ====");
      print(response.body);

      Map<String, dynamic> map = jsonDecode(response.body);

      if (map["status"] == "success") {
        // Save user data in Firestore
        await fireStore.collection('users').doc(uid).set(userData);

        // Save user data in SQLite
        await DatabaseHelper.instance.insertUser(userData);

        Fluttertoast.showToast(
            msg: "Successfully Signed Up",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.to(() =>const LoginScreen());
      } else {
        print("===================================");
        Fluttertoast.showToast(
          msg: map["error"],
          // msg: "Your are already SingUp please logIn with Phone number",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor:kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Sign-up failed: $error");
      print('Error submitting admission data: $error');
    }
  }

  @override
  void dispose() {
    controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                // LOGO .
                SizedBox(
                  height: 50.h,
                  child: Image.asset(
                    AssetIcons.PRIVACY_POLICY_SCREEN_APP_LOGO_ICON,
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controllers['name'],
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          counter: const SizedBox(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          // labelText: " Full name",
                          hintText: " Full name",
                        ),
                      ),
                      SizedBox(height: 10.h),
                      DropdownButtonFormField<String>(
                        value: selectedGender,
                        items: genderOptions.map((String gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          isDense: true,
                          counter: const SizedBox(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          // labelText: 'Gender',
                          hintText: 'Gender',
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue;
                            controllers['gender']!.text = selectedGender ?? ' ';
                          });
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: controllers['schoolName'],
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          counter: const SizedBox(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          // labelText: " Your School Name",
                          hintText: " Your School Name",
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        obscureText: obscureText,
                        controller: controllers['password'],
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            isDense: true,
                            counter: const SizedBox(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            // labelText: "Password",
                            hintText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                              onPressed: (){
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              }, )
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        obscureText: true,
                        controller: controllers['confirmPassword'],
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          counter: const SizedBox(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          // labelText: "Confirm Password",
                          hintText: "Confirm Password",
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        initialValue: StudentDetails.mobile,
                        enabled: false,
                        decoration: InputDecoration(
                            isDense: true,
                            counter: const SizedBox(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            // labelText: "PhoneNumber",
                            hintText: "PhoneNumber",
                            suffixIcon: const Icon(
                              Icons.check_circle_outline_outlined,
                              color: Colors.green,
                              size: 30,
                            )),
                        readOnly: true,
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: controllers['email'],
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          counter: const SizedBox(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          // labelText: "Email address",
                          hintText: "Email address",
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Checkbox(
                            value: agreedToTerms1,
                            onChanged: (bool? value) {
                              setState(() {
                                agreedToTerms1 = value ?? false;
                              });
                            },
                            activeColor: Colors.black,
                          ),
                          const Text(
                            'I would like to receive marketing offers and \npromotional communications \nfrom scolage.',
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 03,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: agreedToTerms2,
                            onChanged: (bool? value) {
                              setState(() {
                                agreedToTerms2 = value ?? false;
                              });
                            },
                            activeColor: Colors.black,
                          ),
                          const Text(
                            'By creating an account or signing in you \nagree with our terms and conditions.',
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 13,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: kPrimaryColor,
                            ),
                            CommonSqTextButton(
                              name: "Terms and Condition",
                              isSelected: true,
                              fontSize: 15,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage()));
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      CommonSaveAndSubmitButton(
                        name: "Submit",
                        onTap: () async {
                          if (agreedToTerms1 && agreedToTerms2) {
                            if (controllers['password']!.text == controllers['confirmPassword']!.text) {
                              await _submitSingUpData();
                            } else {
                              Fluttertoast.showToast(
                                msg: "Passwords do not match",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: kPrimaryColor,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please agree to the terms and conditions",
                            );
                          }
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}