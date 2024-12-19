import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_scolage/module/home/view/widget/rate_in_star_widget.dart';

import '../../../../utils/constant/asset_icons.dart';
import '../../../college/services/review_api.dart';

class CollegeCardDetail extends StatefulWidget {
  CollegeCardDetail({super.key, this.clgName, this.clgAdd,required this.clgId,this.systemType});

  final String? clgName;
  final String? clgAdd;
  final String clgId;
  final String? systemType;

  @override
  State<CollegeCardDetail> createState() => _CollegeCardDetailState();
}

class _CollegeCardDetailState extends State<CollegeCardDetail> {
  List<dynamic> reviewData = [];
  var reviewStar;


  double calculateAverageReview() {
    if (reviewData.isEmpty) {
      return -1.0;
    }
    double totalStars = 0.0;
    for (var review in reviewData) {
      totalStars += double.parse(review["data"]["reviewStar"].toString());
    }
    return totalStars / reviewData.length;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(calculateAverageReview == -1.0){
      print("No any Review in this college");
      // Fluttertoast.showToast(
      //   msg: "No reviews available for this college.",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
    }else {
      // Display the average review
      print("Average Review: $calculateAverageReview");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ReviewsApi.getReviewsApi(widget.clgId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text("there is an error for college card detail widgets",));
            } else if (snapshot.hasData) {
              reviewData = snapshot.data!;
              print("data == $reviewData");
            }
          }

          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  // BoxShadow(
                  //     color: Colors.black.withOpacity(.7),
                  //     blurRadius: 10,
                  //     spreadRadius: 6,
                  //     offset: Offset(0, 10))
                ]),
            child: Column(
              children: [
                SizedBox(height: 6.h),
                // NAME AND ADMISSION OPEN ROW
                Padding(
                  padding: EdgeInsets.only(left: 13.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetIcons.PROTECT_RED_ICON,
                        height: 14.h,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          widget.clgName!,
                          overflow: TextOverflow.ellipsis,
                          // "Kites Jr. Collage",
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: "Poppins",fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 08.w),
                        child: Row(
                          children: [
                            Text(
                              "Admissions",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color.fromRGBO(35, 31, 32, 1),fontFamily: "Poppins"
                              ),
                            ),
                            SizedBox(width: 05.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 07.w, vertical: .5.h),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              child: Text(
                                "OPEN",
                                style: TextStyle(
                                  fontSize: 08.sp,
                                  color: Colors.white,fontFamily: "Poppins"
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                // ADDRESS AND RATE ROW
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w,),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            widget.clgAdd!,
                            overflow: TextOverflow.ellipsis,
                            // "Begumpet, Vijaya colony",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color.fromRGBO(102, 102, 102, 1),fontFamily: "Poppins"),
                          ),
                        ),
                        RateInStarWidget(
                          iconSize: 15,
                          reviewStar: calculateAverageReview().toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                // DISTANCE AND RATE IN COUNT ROW
                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 13),
                      child: Text(
                        "${widget.systemType} | 0km",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color.fromRGBO(35, 31, 32, 1),
                            fontFamily: "Poppins",
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${calculateAverageReview().toStringAsFixed(1)} (${reviewData.length.toString()} )",
                      style: TextStyle(
                        fontSize: 08.sp,
                        color: const Color.fromRGBO(35, 31, 32, 1),
                          fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
                SizedBox(height: 4.h),
              ],
            ),
          );
        });
  }
}
