import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';

class CommonCreateAccountDropDown extends StatelessWidget {
  const CommonCreateAccountDropDown(
      {super.key,
      required this.hintText,
      required this.values,
      required this.onChanged,
      // required this.labelText
      });
  // final String labelText;
  final String hintText;
  final List<String> values;
  final Function(String? selected) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: EdgeInsets.only(left: 12.w, bottom: 3.h, top: 8.h),
        //   child: Text(
        //     labelText,
        //     style: TextStyle(
        //       fontSize: 15.sp,
        //     ),
        //   ),
        // ),
        DropdownButtonFormField2(
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          isExpanded: true,
          hint: Text(
            'Select Your Role',
            style:
                TextStyle(fontSize: 18.sp, color: grey128Color.withOpacity(.5)),
          ),
          items: values
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 18.sp, color: grey128Color),
                    ),
                  ))
              .toList(),
          validator: (value) {
            if (value == null) {
              return 'Please select gender.';
            }
            return null;
          },
          onChanged: (value) {
            onChanged(value);
          },
          onSaved: (value) {
            onChanged(value);
          },
          buttonStyleData: ButtonStyleData(
            height: 40,
            padding: EdgeInsets.only(right: 18.w),
          ),
          iconStyleData: IconStyleData(
            icon: Image.asset(
              AssetIcons.DROP_DOWN_ICON,
              height: 10,
            ),
            iconSize: 22,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ],
    );
  }
}
