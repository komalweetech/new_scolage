import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/common_color.dart';
import '../../../home/view/widget/rate_in_star_widget.dart';

class ReviewListTile extends StatelessWidget {
  const ReviewListTile({super.key, required this.name,required this.reviewText, required this.reviewStar,});
  final String name;
  final String reviewText;
  final String reviewStar;
  // final String? collegeName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 38.h,
              width: 38.h,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(name,style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w600),),
                  ),
                  SizedBox(height: 5.h),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 4.w),
                  //   child: Text("College Name: ${collegeName}"),
                  // ),
                  // SizedBox(height: 3.h),
                  Row(
                    children: [
                     // RatingBar.builder(
                     //   initialRating: double.parse(reviewStar),
                     //     minRating: 3,
                     //     direction: Axis.horizontal,
                     //     allowHalfRating: true,
                     //     itemCount: 5,
                     //     itemSize: 20,
                     //     // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                     //     itemBuilder: (context,_)  =>
                     //            const Icon(Icons.star_rate_rounded,
                     //           color: Color.fromRGBO(255, 214, 0, 1),),
                     //     onRatingUpdate: (rating) {
                     //     print(rating);
                     //     }),
                      RateInStarWidget(iconSize: 20,reviewStar: reviewStar,),
                      SizedBox(width: 4.h),
                      const Expanded(
                        child: Text(
                          "   1 days ago",
                          style: TextStyle(color: grey128Color,fontFamily: "Poppins",fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding:  EdgeInsets.only(left: 08.w),
                    child: Text(
                      reviewText,
                      // "Best place for tuitions. Service counselor Sushmitha M) is very friendly speaking. Each and every one at learning centre are good at their services. Student will feel fun while they learn through Byju's.",
                      style: TextStyle(color: grey102Color, fontSize: 12.5.sp,fontFamily: "Poppins",fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        // Text(
        //   reviewText,
        //   // "Best place for tuitions. Service counselor Sushmitha M) is very friendly speaking. Each and every one at learning centre are good at their services. Student will feel fun while they learn through Byju's.",
        //   style: TextStyle(color: grey102Color, fontSize: 12.5.sp,),
        // )
      ],
    );
  }
}
