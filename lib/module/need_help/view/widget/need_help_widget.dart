import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/commonWidget/keyboard_off.dart';
import '../../../../utils/constant/asset_icons.dart';

class NeedHelpWidget extends StatelessWidget {
  const NeedHelpWidget({super.key, this.isOpenFromNavBar});

  final bool? isOpenFromNavBar;

  @override
  Widget build(BuildContext context) {
    return KeyBoardOff(
      child: ListView(
        children: [
          isOpenFromNavBar ?? false ? SizedBox(height: 50.h) : const SizedBox(),
          Image.asset(
            AssetIcons.HELP_SCREEN_APP_LOGO_ICON,
            width: 60.w,
            height: 75.h,
          ),
          SizedBox(height: 16.h),
          Center(
            child: Text(
              "Scolage Help Assistant",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Colors.black87,
                  fontFamily: "Poppins"),
            ),
          ),
          SizedBox(height: 2.h),
          Center(
            child: Text(
              "We’re here for your queries",
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "Poppins",
                color: const Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
          ),
          SizedBox(height: 55.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              "Write to us with the\nhelp you seek.",
              textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23.sp,
                    color: Colors.black87,
                    fontFamily: "Poppins"),
            ),
          ),
          SizedBox(height: 16.h),
          // TEXT FIELD
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextFormField(
              controller: TextEditingController(),
              maxLines: 5,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                alignLabelWithHint: true,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // SUBMIT BUTTON
          CommonSaveAndSubmitButton(
            name: "Submit",
            onTap: () {},
          )
        ],
      ),
    );
  }
}
