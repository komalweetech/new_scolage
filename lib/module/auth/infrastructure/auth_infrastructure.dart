// ignore_for_file: use_build_co, use_build_context_synchronously
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/networking/firebase_auth_object.dart';
import '../../../utils/commonFunction/common_bottom_sheet_function.dart';
import '../../../utils/commonFunction/common_snackbar.dart';
import '../../../utils/commonWidget/common_loading_dialog.dart';
import '../../../utils/enum/ui_enum.dart';
import '../view/screen/create_account_screen.dart';
import '../view/screen/otp_ButtomSheet.dart';

class AuthInfrastructure {
  // MOBILE AUTH
  Future<void> mobileNumberAuthentication({
    required String mobileNumber,
    required BuildContext context,
  }) {
    CommonLoadingDialog.showLoadingDialog();
    log('CALLED', name: 'mobileNumberAuthentication');
    return FirebaseAuthObject.instance.verifyPhoneNumber(
      phoneNumber: "+91$mobileNumber",
      verificationFailed: (FirebaseAuthException e) {
        CommonLoadingDialog.cancelDialog();
        if (e.code == 'invalid-phone-number') {
          log(
            'The provided phone number is not valid.',
            name: 'mobileNumberAuthentication-verificationFailed',
          );
          CommonSnackbar.showSnackBar(context,
              'The provided phone number is not valid.', StatusType.error);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        CommonLoadingDialog.cancelDialog();
        // MOVE TO OTP SCREEN WITH VERIFICATION ID WITH MOBILE NUMBER
        await commonBottomSheetFunction(
          isScrollControlled: true,
          child: const OtpBottomSheet(isFromForgotPasscode: false),
          context: context,
        );
        CommonSnackbar.showSnackBar(
            context, 'OTP Sent Successfully', StatusType.success);
      },
      verificationCompleted: (PhoneAuthCredential credential) async {
        log(
          'PhoneAuthCredential :- $credential',
          name: 'mobileNumberAuthentication-verificationCompleted',
        );
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        log(
          'verificationId :- $verificationId',
          name: 'mobileNumberAuthentication-codeAutoRetrievalTimeout',
        );
      },
    );
  }

  // OTP VERIFICATION
  Future<UserCredential?> otpVerification(
      {required BuildContext context,
      required String verificationId,
      required String mobileNumber,
      required String otp}) async {
    try {
      CommonLoadingDialog.showLoadingDialog();
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => CreateAccountScreen(),
          ), (t) {
        return false;
      });
      log(userCredential.toString());
      CommonLoadingDialog.cancelDialog();
      return userCredential;
    } on FirebaseAuthException catch (e, st) {
      CommonLoadingDialog.cancelDialog();
      switch (e.code) {
        case "invalid-phone-number":
          CommonSnackbar.showGetSnackBar(
            'Invalid phone number',
            StatusType.error,
          );
          break;
        case "session-expired":
          CommonSnackbar.showGetSnackBar(
            'Your Session is expired please try again',
            StatusType.error,
          );
          break;
        case "invalid-verification-code":
          CommonSnackbar.showGetSnackBar(
            "Invalid OTP",
            StatusType.error,
          );
          break;
        default:
      }
      log(e.toString(), error: e, stackTrace: st);
      return null;
    }
  }
}
