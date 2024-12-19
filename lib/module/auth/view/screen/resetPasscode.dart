import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import 'login_screen.dart';

class ResetPassCode extends StatefulWidget {
  const ResetPassCode({super.key});

  @override
  State<ResetPassCode> createState() => _ResetPassCodeState();
}

class _ResetPassCodeState extends State<ResetPassCode> {
final  TextEditingController _passCodeController = TextEditingController();
final  TextEditingController _conformCodeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 100.h),
            // LOGO .
            SizedBox(
              height: 80.h,
              child: Image.asset(
                AssetIcons.PRIVACY_POLICY_SCREEN_APP_LOGO_ICON,
              ),
            ),
            SizedBox(height: 50.h),
            // TEXT .
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  // MOBILE NUMBER FIELD
                  TextField(
                    controller:_passCodeController,
                    maxLength: 10,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      isDense: true,
                      counter: const SizedBox(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      labelText: " Enter New passcode",
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // MOBILE NUMBER FIELD
                  TextField(
                    obscureText: true,
                    controller:_conformCodeController,
                    maxLength: 10,
                    decoration: InputDecoration(
                      isDense: true,
                      counter: const SizedBox(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      labelText: " Confirm passcode",

                    ),
                  ),
                  SizedBox(height: 10.h),
                  CommonSaveAndSubmitButton(
                    name: "Submit",
                    onTap: (){
                      if(_passCodeController.text == _conformCodeController.text ){
                        Fluttertoast.showToast(
                          msg: "Reset your Password",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: kPrimaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        Get.to(() => LoginScreen()) ;
                      } else {
                        Fluttertoast.showToast(msg: "Passwords do not match",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: kPrimaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0,);
                      }
                      }
                    ,padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
