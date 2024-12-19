import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/commonWidget/common_screen_content_title.dart';
import '../../../home/view/widget/college_card.dart';

class FavCollegeListWidget extends StatelessWidget {
  const FavCollegeListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      itemCount: 6,
      itemBuilder: (context, index) => index == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonScreenContentTitle(
                  title: "Your Fav collages",
                  padding: EdgeInsets.all(0),
                ),
                SizedBox(height: 20.h),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Text(
                //         "Hyderabad",
                //         style: TextStyle(fontSize: 18.sp),
                //       ),
                //     ),
                //     Text(
                //       "1 saved college",
                //       style: TextStyle(
                //         fontSize: 12.sp,
                //         color: const Color.fromRGBO(116, 116, 116, 1),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            )
          : CollegeCard(
              index: index,
              height: 200.h,
              width: 100.w,
            ),
      separatorBuilder: (context, index) => SizedBox(height: 20.h),
    );
  }
}
