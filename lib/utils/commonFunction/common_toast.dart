import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../enum/ui_enum.dart';
import '../theme/common_color.dart';

abstract class CommonToast {
  //Coming soon toast message
  static showComingSoonToast() {
    Fluttertoast.showToast(
        msg: "Coming soon...",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 0,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
        fontSize: 12.0);
  }

  static showToast(String message, StatusType statusType) {
    Color? backgroundColor;
    switch (statusType) {
      case StatusType.success:
        backgroundColor = statusType.statusColor;
        break;
      case StatusType.error:
        backgroundColor = statusType.statusColor;
        break;
      case StatusType.info:
        backgroundColor = statusType.statusColor;
        break;
      default:
    }

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 0,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
        fontSize: 12.0);
  }
}

extension StatusTypeHelper on StatusType {
  Color get statusColor {
    switch (this) {
      case StatusType.success:
        return Colors.green;
      case StatusType.error:
        return Colors.redAccent;
      case StatusType.info:
        return kPrimaryColor;
    }
  }

  IconData get statusIcon {
    switch (this) {
      case StatusType.success:
        return Icons.check_circle;
      case StatusType.error:
        return Icons.error;
      case StatusType.info:
        return Icons.info;
    }
  }
}
