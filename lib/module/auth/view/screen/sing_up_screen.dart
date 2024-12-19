import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../utils/StudentDetails.dart';
import '../../../../utils/apiData/api_base_port.dart';
import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/commonWidget/common_sq_text_button.dart';
import '../../../../utils/constant/asset_icons.dart';
import 'package:http/http.dart' as http;

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
  Map<String, TextEditingController> controllers = {};
  String? selectedGender;
  List<String> genderOptions = ['Male', 'Female', 'Other'];
  bool isSelected = false;
  bool agreedToTerms1 = false;
  bool agreedToTerms2 = false;
  bool obscureText = true;

  void _createTextEditingController(String fieldName) {
    controllers[fieldName] = TextEditingController();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _createTextEditingController('role');
    _createTextEditingController('name');
    _createTextEditingController('gender');
    // _createTextEditingController(selectedGender!);
    _createTextEditingController('school_name');
    _createTextEditingController('password');
    _createTextEditingController('confirm_password');
    // _createTextEditingController('mobile');
    _createTextEditingController('email');
  }

  @override
  void dispose() {
    super.dispose();
    controllers.forEach((key, controller) => controller.dispose());
  }

  Future<void> _submitSingUpData() async {
    // Check if any of the fields are empty
    if (controllers['name']!.text.isEmpty ||
        controllers['gender']!.text.isEmpty ||
        controllers['school_name']!.text.isEmpty ||
        controllers['password']!.text.isEmpty ||
        controllers['confirm_password']!.text.isEmpty ||
        controllers['email']!.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill in all fields",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return; // Return to exit the function if any field is empty
    }

    // String apiUrl = 'https://backend.scolage.com/v2/reg/students';
    String apiUrl = '${ApiBasePort.apiBaseUrl}/v2/reg/students';
    String? studentId = StudentDetails.studentId;

    Map<String, dynamic> signUpData  = {
      'role': "student",
      'name': controllers['name']?.text,
      'gender': controllers['gender']?.text,
      'school_name': controllers['school_name']?.text,
      'password': controllers['password']?.text,
      'confirm_password': controllers['confirm_password']?.text,
      'mobile': StudentDetails.mobile,
      'email': controllers['email']?.text,
    };

    print("your student id ===== $studentId}");
    print("your details == $signUpData ");

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(signUpData ),
        headers: {'Content-Type': 'application/json'},
      );
      print("Response ====");
      print(response.body);

      Map<String, dynamic> map = jsonDecode(response.body);

      if (map["status"] == "success") {
        // Insert data into SQLite database
        await DatabaseHelper.instance.insertUser(signUpData);

        Fluttertoast.showToast(
            msg: "Successfully Signed Up",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.to(() =>const LoginScreen());
      } else {
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
      print('Error submitting admission data: $error');
    }
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
                      labelText: " Full name",
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
                      labelText: 'Gender',
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                        controllers['gender']?.text = selectedGender ?? ' ';
                      });
                    },
                  ),
                  SizedBox(height: 10.h),
                  TextFormField(
                    controller: controllers['school_name'],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      counter: const SizedBox(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      labelText: " Your School Name",
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
                      labelText: "Password",
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
                    controller: controllers['confirm_password'],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      counter: const SizedBox(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      labelText: "Confirm Password",
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
                        labelText: "PhoneNumber",
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
                      labelText: "Email address",
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
                          onTap: () => WebViewPage(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CommonSaveAndSubmitButton(
                    name: "Submit",
                    onTap: () async {
                      if (agreedToTerms1 && agreedToTerms2) {
                        if (controllers['password']?.text ==
                            controllers['confirm_password']?.text) {
                          await _submitSingUpData();
                          // Fluttertoast.showToast(
                          //   msg: "Succesfully SingUp",
                          //   toastLength: Toast.LENGTH_LONG,
                          //   gravity: ToastGravity.BOTTOM,
                          //   timeInSecForIosWeb: 2,
                          //   backgroundColor: Colors.red,
                          //   textColor: Colors.white,
                          //   fontSize: 16.0,
                          // );
                          // Get.to(() => LoginScreen()) ;
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
