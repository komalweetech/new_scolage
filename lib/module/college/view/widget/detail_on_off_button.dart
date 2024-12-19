import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';

class DetailOnOffButton extends StatelessWidget {
  const DetailOnOffButton(
      {super.key,
      required this.onTap,
      required this.isDetailDisplayed,
      required this.name});
  final VoidCallback onTap;
  final bool isDetailDisplayed;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Material(
        color: commonYellowColor,
        borderRadius: BorderRadius.circular(8.h),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.h),
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, .5.h, 20.w, 3.5.h),
                  child: Text(name,style: TextStyle(fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.w700),),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 20.w),
                child: Image.asset(
                  isDetailDisplayed
                      ? AssetIcons.DETAIL_ON_ICON
                      : AssetIcons.DETAIL_OFF_ICON,
                  height: 15.h,
                  width: 15.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
