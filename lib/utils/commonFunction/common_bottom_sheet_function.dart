import 'package:flutter/material.dart';

Future<void> commonBottomSheetFunction(
    {required BuildContext context,
    required Widget child,
    bool? isScrollControlled}) async {
  await showModalBottomSheet(
    barrierColor: const Color.fromRGBO(32, 14, 50, .5),
    enableDrag: true,
    isScrollControlled: isScrollControlled ?? false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
    context: context,
    builder: (context) => child,
  );
}
