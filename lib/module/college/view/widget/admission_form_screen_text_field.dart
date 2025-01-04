// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdmissionFormScreenTextField extends StatelessWidget {
  const AdmissionFormScreenTextField({
    Key? key,
    required this.controller,
    this.prefix,
    this.labelText,
    this.enabled,
    this.padding,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.readOnly,
    this.onTap,
    this.suffix,
    this.line,
    this.autofocus,
    this.maxLength,
    this.hintText,
    this.fontSize,
  }) : super(key: key);

  final TextEditingController controller;
  final Widget? prefix;
  final Widget? suffix;
  final String? labelText;
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
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // labelText != null
        //     ? Padding(
        //         padding: EdgeInsets.only(left: 6.w, bottom: 3.h, top: 10.h),
        //         child: Text(
        //           labelText ?? '',
        //           style: TextStyle(
        //             fontSize: 14.sp,fontFamily: "Poppins",
        //           ),
        //         ),
        //       )
        //     :
        SizedBox(height: 15.h),
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
            fontSize: fontSize ?? 14.h,
            color: Color.fromRGBO(159, 159, 159, 1),fontFamily: "Poppins",
          ),
          decoration: InputDecoration(
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                strokeAlign: 10,
                width: .5,
                color: Color.fromRGBO(51, 51, 51, .8),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                strokeAlign: 10,
                width: .5,
                color: Color.fromRGBO(51, 51, 51, .8),
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
            prefixIcon: prefix,
            suffixIcon: suffix,
            hintText: hintText,
            alignLabelWithHint: true,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
