import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/StudentDetails.dart';
import '../../../../utils/collegedatalist.dart';
import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/commonWidget/keyboard_off.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../home/view/widget/college_card_detail_widget.dart';
import '../../services/review_api.dart';

class WriteAReviewScreen extends StatefulWidget {
  const WriteAReviewScreen({super.key, required this.clgId});

  final String clgId;

  @override
  State<WriteAReviewScreen> createState() => _WriteAReviewScreenState();
}

class _WriteAReviewScreenState extends State<WriteAReviewScreen> {
  TextEditingController reviewTextController = TextEditingController();

  // TextEditingController reviewStarController = TextEditingController();
  double _rating = 0.0;

  List<dynamic> collegeData = [];
  List<dynamic> subCollegeList = [];
  List<dynamic> collegeImageList = [];
  List<dynamic> subCollegeImageList = [];

  var clgImage;
  var clgName;
  var clgAdd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    collegeData.add(AllCollegeData.collegeDataList["college"]);
    print("rewie screen data == $collegeData");

    subCollegeList = collegeData.isNotEmpty ? collegeData[0] : [];
    print("review screen subCollege List == $subCollegeList");

    collegeImageList.add(AllCollegeData.collegeDataList["clgimage"]);
    print("rewie screen data  Image List== $collegeImageList");

    subCollegeImageList =
        collegeImageList.isNotEmpty ? collegeImageList[0] : [];
    print("review screen subCollegeImage List == $subCollegeImageList");

    for (int i = 0; i < subCollegeList.length; i++) {
      if (widget.clgId == subCollegeList[i]["collegeid"].toString()) {
        clgName = subCollegeList[i]["collegename"].toString();
        clgAdd = subCollegeList[i]["address"].toString();
        print("review screens clgName === $clgName");
        print("review screen clgAdd ==== $clgAdd");
        print("review screen college Id = ${widget.clgId}");
        print(
            "review screen CollegeId === ${subCollegeList[i]["collegeid"].toString()}");
        break;
      }
    }
    for (int i = 0; i < subCollegeImageList.length; i++) {
      if (widget.clgId == subCollegeImageList[i]["collegeid"].toString()) {
        clgImage = subCollegeImageList[i]["imageUrl"].toString();
        print("review screen collegeImage = $clgImage");
        break;
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    reviewTextController.dispose();
    // reviewStarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyBoardOff(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: Colors.white,
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
              "Write a Review",
              style:
                  TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              children: [
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Container(
                      height: 65.h,
                      width: 60.h,
                      decoration: BoxDecoration(
                        border: Border.all(width: .5),
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          7.r,
                        ),
                        child: Image.network(
                          clgImage,
                          fit: BoxFit.cover,
                        ),
                        // Image.asset(
                        //   "assets/image/college_detail_image.png",
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: .5),
                          borderRadius: BorderRadius.circular(
                            8.r,
                          ),
                        ),
                        child: CollegeCardDetail(
                          clgName: clgName,
                          clgAdd: clgAdd,
                          clgId: widget.clgId,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60.h),
                // TEXT FIELD
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                    "Write your Review",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: reviewTextController,
                  maxLines: 5,
                  maxLength: 400,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    counterText: "400 characters remaining",
                    counterStyle:
                        TextStyle(fontSize: 12.sp, color: grey128Color),
                    hintText:
                        "Would you like to write anything about\nthe college?",
                    hintStyle: TextStyle(fontSize: 13.sp, color: grey128Color, fontFamily: "Poppins",),
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    alignLabelWithHint: true,
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                    "Rate the college:",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 10.h),
                // TextFormField(
                //   keyboardType: TextInputType.number,
                //   controller: reviewStarController,
                //   maxLines: 3,
                //   maxLength: 50,
                //   textAlignVertical: TextAlignVertical.center,
                //   decoration: InputDecoration(
                //     counterText: "Give your rating stars in int text",
                //     counterStyle: TextStyle(fontSize: 12.sp, color: grey128Color),
                //     hintText: "Would you like to  give rating stars for us?",
                //     hintStyle: TextStyle(fontSize: 14.sp, color: grey128Color),
                //     isDense: true,
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(8),
                //         borderSide: const BorderSide(color: Colors.black)),
                //     contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                //     alignLabelWithHint: true,
                //   ),
                // ),
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 2,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                SizedBox(height: 16.h),
              ],
            ),
            // WRITE REVIEW BUTTON
            Positioned(
              bottom: 0,
              right: 16.w,
              left: 16.w,
              child: SafeArea(
                minimum: EdgeInsets.only(bottom: 16.h),
                child: CommonSaveAndSubmitButton(
                  name: "Submit review",
                  onTap: () async {
                    await ReviewsApi.postApi(
                        widget.clgId,
                        StudentDetails.studentId,
                        reviewTextController.text,
                        _rating.toString());
                  },
                  padding: EdgeInsets.zero,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
