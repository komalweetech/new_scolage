import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/StudentDetails.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../college/services/review_api.dart';
import '../../../college/view/widget/review_list_tile.dart';

class DrawerReviewScreen extends StatefulWidget {
  const DrawerReviewScreen({super.key,required this.studentId});
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
      print("drawer review data = ${ReviewsApi.getStudentReview(widget.studentId)}");
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
    print("drawer review data = ${ReviewsApi.getStudentReview(widget.studentId)}");
    print("student id  1111111==== ${StudentDetails.studentId}");
    print("name ==== ${StudentDetails.name}");
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
            "My Reviews",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
          future:ReviewsApi.getStudentReview(widget.studentId),
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
                  padding:  const EdgeInsets.only(left: 30,top: 30,bottom: 20),
                  child: ListView(
                    children: [
                      reviewData .isNotEmpty  ?
                      ListView.separated(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: reviewData.length,
                        itemBuilder: (context, index) =>
                            ReviewListTile(
                              name: reviewData[index]["data"]["studentname"].toString(),
                              // collegeName: reviewData[index]["data"]["collegename"].toString(),
                              reviewText:reviewData[index]["data"]["text"].toString(),
                              reviewStar: reviewData[index]["data"]["reviewStar"].toString(),
                            ) ,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 25.h),
                      ) :  const Align(
                        alignment: Alignment.center,
                          child: Text("You not give any Review in any colleges..",style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)),
                    ],
                  ),
                ),
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
