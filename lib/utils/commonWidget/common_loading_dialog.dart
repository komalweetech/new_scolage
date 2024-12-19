import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonLoadingDialog {
  static void showLoadingDialog() {
    Get.dialog(
      WillPopScope(
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 25,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        'Loading...',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    Get.back();
  }
}
