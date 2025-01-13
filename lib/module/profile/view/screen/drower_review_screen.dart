import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:new_scolage/module/dashboard/view/screen/dashboard_screen.dart';

import '../../../../utils/StudentDetails.dart';
import '../../../../utils/commonWidget/common_screen_content_title.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../college/services/review_api.dart';
import '../../../college/view/widget/review_list_tile.dart';
import '../../../dashboard/view/widget/simple_common_appbar.dart';

class DrawerReviewScreen extends StatefulWidget {
  const DrawerReviewScreen({super.key, required this.studentId});

  final String studentId;

  @override
  State<DrawerReviewScreen> createState() => _DrawerReviewScreenState();
}

class _DrawerReviewScreenState extends State<DrawerReviewScreen> {
  List<dynamic> reviewData = [];
  List<dynamic> filterReviewData = [];

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      ReviewsApi.getStudentReview(StudentDetails.studentId);
      // DrawerReviewDataUtils();
      print(
          "drawer review data = ${ReviewsApi.getStudentReview(widget.studentId)}");
      print("student id  1111111==== ${StudentDetails.studentId}");
      print("widget.studentId== ${widget.studentId}");

      print("name ==== ${StudentDetails.name}");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReviewsApi.getStudentReview(widget.studentId);
    // ReviewDataUtils();
    print(
        "drawer review data = ${ReviewsApi.getStudentReview(widget.studentId)}");
    print("student id  1111111==== ${StudentDetails.studentId}");
    print("name ==== ${StudentDetails.name}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(95 + MediaQuery.of(context).padding.top),
        child: const SimpleCommonAppBar(),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
          future: ReviewsApi.getStudentReview(widget.studentId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("there is an error for Drawer review screen"),
                );
              } else if (snapshot.hasData) {
                reviewData = snapshot.data!;
                print("drawer review data == $reviewData");
              }
            }
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10,left: 10),
                  child: const Text("My Reviews",style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Poppins",
                  ),),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20,left: 20),
                    child: reviewData.isNotEmpty
                        ? ListView.separated(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: reviewData.length,
                            itemBuilder: (context, index) => ReviewListTile(
                              name: reviewData[index]["data"]["studentname"]
                                  .toString(),
                              // collegeName: reviewData[index]["data"]["collegename"].toString(),
                              reviewText:
                                  reviewData[index]["data"]["text"].toString(),
                              reviewStar: reviewData[index]["data"]
                                      ["reviewStar"]
                                  .toString(),
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 25.h),
                          )
                        : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
                                child: Image.asset(AssetIcons.NoAnyDataPNG,),
                              ),
                              SizedBox(height: 20.h,),
                              Text(
                                "No review data available",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                ),
                              ),
                              Text(
                                "Start searching for colleges now",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color.fromRGBO(
                                        128, 128, 128, 1)),
                              ),
                              SizedBox(height: 20.h),
                              GestureDetector(
                                onTap: () {
                                  Get.to(DashboardScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.w, vertical: 10.h),
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
                        )),
                SizedBox(height: 90.h),
                // WRITE REVIEW BUTTON
              ],
            );
          },
        ),
      ),
    );
  }
}
