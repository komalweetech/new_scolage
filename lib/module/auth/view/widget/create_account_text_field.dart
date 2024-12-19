import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/common_color.dart';

class CreateAccountTextField extends StatelessWidget {
  const CreateAccountTextField(
      {super.key,
      required this.controller,
      this.prefix,
      this.suffix,
      required this.labelText,
      this.hintText,
      this.padding,
      this.inputFormatters,
      this.keyboardType,
      this.textInputAction,
      this.validator,
      this.readOnly,
      this.onTap,
      this.line,
      this.enabled,
      this.autofocus,
      this.maxLength});

  final TextEditingController controller;
  final Widget? prefix;
  final Widget? suffix;
  final String labelText;
  final String? hintText;
  final EdgeInsetsGeometry? padding;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final VoidCallback? onTap;
  final int? line;
  final bool? enabled;
  final bool? autofocus;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.w, bottom: 3.h, top: 8.h),
              child: Text(
                labelText,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
            ),
            TextFormField(
              readOnly: readOnly ?? false,
              autofocus: autofocus ?? false,
              onTap: onTap,
              controller: controller,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              maxLines: line,
              textAlignVertical: TextAlignVertical.center,
              enabled: enabled,
              maxLength: maxLength,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: grey128Color.withOpacity(.5)),
                isDense: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                prefixIcon: prefix,
                suffixIcon: suffix,
                hintText: hintText,
                alignLabelWithHint: true,
              ),
              validator: validator,
            ),
          ],
        )
      ],
    );
  }
}
