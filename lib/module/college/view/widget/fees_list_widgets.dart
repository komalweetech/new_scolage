import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeesListWidget extends StatelessWidget {
  const FeesListWidget({super.key, required this.title,required this.minFees,required this.maxFees});
  final String title;
  final String minFees;
  final String maxFees;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: const Color.fromRGBO(225, 244, 253, 1),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Text(title,style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500),),
              ),
            ),
            const VerticalDivider(
              width: .5,
              color: Colors.black54,
            ),
             Expanded(
              flex: 7,
              child: Text(
                "$minFees - $maxFees",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w700,color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
