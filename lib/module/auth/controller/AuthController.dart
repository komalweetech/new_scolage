import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/validator/validator_const.dart';
import '../../../utils/commonFunction/common_snackbar.dart';
import '../../../utils/enum/ui_enum.dart';

class AuthController extends GetxController {
  // LOGIN FORM DATA
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController =  TextEditingController();

  late Timer timerInstance;
  RxInt duration = 30.obs;
  RxBool isLoading = false.obs;

  void startTimer() {
    duration.value = 30;
    const oneSec = Duration(seconds: 1);
    timerInstance = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (duration.value == 0) {
          // setState(() {
          timer.cancel();
          isLoading.value = false;
          isLoading.refresh();
          // });
        } else {
          // setState(() {
          duration.value--;
          // });
        }
      },
    );
  }

  // MOBILE NUMBER VALIDATOR
  bool isValidMobileNumber(
      {required String mobileNumber, required BuildContext context}) {
    String? error = ValidatorConst.validateMobileNumber(mobileNumber);
    if (error != null) {
      CommonSnackbar.showSnackBar(context, error, StatusType.error);
      return false;
    } else {
      return true;
    }
  }
}
