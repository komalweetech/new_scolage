import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/common_color.dart';

class FilePickerBox extends StatelessWidget {
  const FilePickerBox(
      {super.key,
      required this.documentName,
      required this.onTap,
      this.pickedFileName});
  final String documentName;
  final String? pickedFileName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 130.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: pickedFileName != null
                  ? kPrimaryColor.withOpacity(.4)
                  : const Color.fromRGBO(204, 204, 204, 1),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: pickedFileName != null
                  ? kPrimaryColor.withOpacity(.4)
                  : const Color.fromRGBO(204, 204, 204, 1),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    documentName,
                    style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w700,
                        color: pickedFileName != null
                            ? Colors.white
                            : grey102Color,
                        fontSize: 12.sp),
                  ),
                  pickedFileName != null
                      ? Text(
                          pickedFileName ?? '',
                          style:
                              TextStyle(color: Colors.white, fontSize: 10.sp),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
