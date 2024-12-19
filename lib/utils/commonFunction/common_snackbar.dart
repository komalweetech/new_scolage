import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../enum/ui_enum.dart';
import 'common_toast.dart';

class CommonSnackbar {
  static void showSnackBar(
      BuildContext context, String message, StatusType statusType,
      {VoidCallback? onTap, String? actionMsg}) {
    Color? backgroundColor;
    IconData? iconData;
    switch (statusType) {
      case StatusType.success:
        backgroundColor = statusType.statusColor;
        iconData = statusType.statusIcon;
        break;
      case StatusType.error:
        backgroundColor = statusType.statusColor;
        iconData = statusType.statusIcon;
        break;
      case StatusType.info:
        backgroundColor = statusType.statusColor;
        iconData = statusType.statusIcon;
        break;
      default:
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
        ),
      );
  }

  static void showGetSnackBar(String message, StatusType statusType,
      {VoidCallback? onTap, String? actionMsg}) {
    Color? backgroundColor;
    IconData? iconData;
    switch (statusType) {
      case StatusType.success:
        backgroundColor = statusType.statusColor;
        iconData = statusType.statusIcon;
        break;
      case StatusType.error:
        backgroundColor = statusType.statusColor;
        iconData = statusType.statusIcon;
        break;
      case StatusType.info:
        backgroundColor = statusType.statusColor;
        iconData = statusType.statusIcon;
        break;
      default:
    }

    Get.showSnackbar(
      GetSnackBar(
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(14),
        messageText: Row(
          children: [
            Icon(
              iconData,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        borderRadius: 10,
        backgroundColor: backgroundColor ?? Colors.black,
      ),
    );
  }
}
