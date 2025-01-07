import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/commonFunction/common_function.dart';
import '../../../nearby/view/screen/nearby_screen.dart';

class NearbyStoryButton extends StatelessWidget {
  const NearbyStoryButton({super.key,required this.cityimage,required this.cityName,this.backgroundColor,                                                                                                                  });
  final String cityimage;
  final String cityName;
  final Color? backgroundColor;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CommonFunction.kNavigatorPush(context, NearbyScreen(collegeCode: cityName,));
      },
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              color: backgroundColor,
              cityimage,
              height: 50.h,
              width: 50.w,
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            cityName,
            style: TextStyle(
              fontSize: 11.sp,fontFamily: "Poppins",fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}
