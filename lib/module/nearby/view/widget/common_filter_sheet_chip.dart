import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/common_color.dart';

// class CommonFilterSheetChip extends StatelessWidget {
//   const CommonFilterSheetChip(
//       {super.key,
//       required this.name,
//       required this.onTap,
//       required this.isSelected});
//   final String name;
//   final VoidCallback onTap;
//   final bool isSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(100),
//         onTap: onTap,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 2.h),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.black : null,
//             borderRadius: BorderRadius.circular(100),
//             border: Border.all(color: grey128Color, width: .5),
//           ),
//           child: Text(
//             name,
//             style: TextStyle(
//               color: isSelected ? Colors.white : grey128Color,
//               fontSize: 14.sp,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class CommonFilterSheetChip extends StatelessWidget {
  const CommonFilterSheetChip({
    Key? key,
    required this.name,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final String name;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 08.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : null,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: grey128Color, width: .5),
          ),
          child: Text(
            name,
            style: TextStyle(
              color: isSelected ? Colors.white : grey128Color,fontFamily: "Poppins",fontWeight: FontWeight.w300,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}