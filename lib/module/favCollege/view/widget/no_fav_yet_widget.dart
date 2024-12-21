import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../utils/commonWidget/common_screen_content_title.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../dashboard/view/screen/dashboard_screen.dart';

class NoFavYetWidget extends StatelessWidget {
  const NoFavYetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const CommonScreenContentTitle(title: "Your Fav colleges"),
        SizedBox(height: 100.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.w),
          child: Center(
            child: Image.asset(AssetIcons.NO_FAV_YET_ICON),
          ),
        ),
        SizedBox(height: 100.h),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No favorites yet",
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              Text(
                "Start searching for colleges now",
                style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color.fromRGBO(128, 128, 128, 1)),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: (){},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "Explore junior colleges",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
