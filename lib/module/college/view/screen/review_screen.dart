
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_scolage/module/college/view/screen/write_a_review_screen.dart';
import '../../../../utils/StudentDetails.dart';
import '../../../../utils/commonFunction/common_function.dart';
import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/commonWidget/common_vertical_divider.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../home/view/widget/rate_in_star_widget.dart';
import '../../services/review_api.dart';
import '../../utils/reviewDataUtils.dart';
import '../widget/review_list_tile.dart';
import '../widget/review_progress_bar_list_widget.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key,  required this.clgId,});
  final String clgId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<dynamic> reviewData = [];
  List<dynamic> filterReviewData = [];

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      ReviewsApi.getReviewsApi(widget.clgId);
      ReviewDataUtils();
      print("review data = ${ReviewsApi.getReviewsApi(widget.clgId)}");
      print("student id  1111111==== ${StudentDetails.studentId}");
      print("name ==== ${StudentDetails.name}");
    });
  }

  int calculateAverageReview() {
    if (reviewData.isEmpty) {
      return 0;
    }
    double totalStars = 0.0;
    for (var review in reviewData) {
      totalStars += double.parse(review["data"]["reviewStar"].toString());
    }
    double average = totalStars / reviewData.length;
    return average.round();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          leadingWidth: 80,
          leading: Center(
            child: Container(
              height: 32.h,
              width: 32.h,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(
                  20.r,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  AssetIcons.COLLEGE_DETAIL_SCREEN_BACK_ARROW_ICON,
                ),
              ),
            ),
          ),
          title: const Text(
            "Reviews",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23,fontFamily: "Poppins",),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
          future:ReviewsApi.getReviewsApi(widget.clgId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("there is an error for Review screen"),
                );
              } else if (snapshot.hasData) {
                reviewData = snapshot.data!;
                print("data == $reviewData");
              }
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
            return Stack(
              children: [
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  children: [
                    SizedBox(height: 16.h),
                    Center(
                      child: Text(
                        calculateAverageReview().toStringAsFixed(1), // Display average review here
                        style: TextStyle(fontSize: 34.sp,fontFamily: "Poppins",fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 6.h),
                     RateInStarWidget(iconSize: 20,reviewStar: calculateAverageReview().toString(),),
                     Center(
                      child: Text(
                        "based on ${reviewData.length} reviews",
                        style: TextStyle(color: grey128Color,fontFamily: "Poppins",fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    // REVIEW CHART
                     ReviewProgressBarListWidget(averageReview: calculateAverageReview(),),
                    SizedBox(height: 25.h),
                    const CommonDivider(thickness: .2),
                    SizedBox(height: 25.h),
                    // REVIEW LIST
                    ListView.separated(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reviewData.length,
                      itemBuilder: (context, index) =>
                          ReviewListTile(
                        name: reviewData[index]["data"]["studentname"].toString(),
                        reviewText:reviewData[index]["data"]["text"].toString(),
                        reviewStar: reviewData[index]["data"]["reviewStar"].toString(),
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 25.h),
                    ),
                    SizedBox(height: 90.h),
                  ],
                ),
                // WRITE REVIEW BUTTON
                Positioned(
                  bottom: 0,
                  right: 16.w,
                  left: 16.w,
                  child: SafeArea(
                    minimum: EdgeInsets.only(bottom: 16.h),
                    bottom: true,
                    child: CommonSaveAndSubmitButton(
                      name: "Write a review",
                      onTap: () {
                        CommonFunction.kNavigatorPush(
                            context,
                            WriteAReviewScreen(
                              clgId: widget.clgId,
                            ));
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
