import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/constant/asset_icons.dart';

class AdmissionFormScreenDropDown extends StatelessWidget {
  const AdmissionFormScreenDropDown(
      {super.key,
        required this.hintText,
        required this.value,
        required this.items,
        required this.onChanged,
        // required this.labelText
      });

  // final String labelText;
  final String value;
  final String hintText;
  final List<String> items;
  final Function(String? selected) onChanged;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: EdgeInsets.only(left: 6.w, bottom: 3.h, top: 10.h),
        //   child: Text(
        //     labelText,
        //     style: TextStyle(
        //       fontSize: 15.sp,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 38,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(5),
          //   border: Border.all(
          //     width: .5,
          //     color: Color.fromRGBO(51, 51, 51, .8),
          //   ),
          // ),
          child: DropdownButtonFormField2<String>(
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(left: 0),
              border: InputBorder.none,
            ),

            isExpanded: true,
            hint: Text(
              '',
              style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color.fromRGBO(159, 159, 159, 1)),
            ),
            items: items
                .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color.fromRGBO(159, 159, 159, 1)),
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: (String? newValue) {
              onChanged(newValue);
            },
            onSaved: (value) {
              onChanged(value);
            },
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: .5,
                  color: const Color.fromRGBO(51, 51, 51, .8),
                ),
              ),
              height: 40,
              padding: EdgeInsets.only(right: 10.w),
            ),
            iconStyleData: IconStyleData(
              icon: Image.asset(
                AssetIcons.DROP_DOWN_ICON,
                height: 6.h,
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
        ),
      ],
    );
  }
}
