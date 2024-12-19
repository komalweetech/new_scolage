import 'dart:io';

import 'package:flutter/material.dart';

abstract class CommonDatePicker {
  static DateTime calenderStartDate = DateTime(2000, 1);
  static DateTime calenderEndDate = DateTime(3000, 12);

  static Future<DateTime?> showCustomDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    if (Platform.isIOS || Platform.isMacOS) {
      return await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? calenderStartDate,
        lastDate: lastDate ?? calenderEndDate,
      );
    } else {
      return await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? calenderStartDate,
        lastDate: lastDate ?? calenderEndDate,
      );
    }
  }
}
