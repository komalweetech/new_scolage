// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../enum/ui_enum.dart';
import 'common_toast.dart';

class CommonFunction {
  // ROUT MANAGING
  static Future<void> kNavigatorPush(
      BuildContext context, Widget screenName) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screenName,
      ),
    );
  }

// KEY BOARD OFF
  static void keyboardOff(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // LAUNCH WHATSAPP
  static Future<void> openWhatsApp(String text) async {
    String url = "https://wa.me/?text=$text";
    final Uri _url = Uri.parse(url);

    if (await canLaunchUrl(_url)) {
      await launchUrl(
        _url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      CommonToast.showToast("Something Went Wrong", StatusType.error);
      throw 'Could not launch $url';
    }
  }

  static Future<void> listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        await requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.provisional:
        break;
    }
  }

  static Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }
}
