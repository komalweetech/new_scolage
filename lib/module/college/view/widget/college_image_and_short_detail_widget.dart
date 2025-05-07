import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:new_scolage/module/college/view/widget/showImage_screen.dart';
import 'package:new_scolage/module/college/view/widget/youtube_Image_widget.dart';
import '../../../../utils/commonFunction/common_function.dart';
import '../../../../utils/commonWidget/common_vertical_divider.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/size/app_sizing.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../home/view/widget/rate_in_star_widget.dart';
import '../../services/review_api.dart';
import '../screen/teaching_video_list_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'gallery_view_screen.dart';

class CollegeImageAndShortDetailWidget extends StatelessWidget {
  const CollegeImageAndShortDetailWidget({
    super.key,
    required this.clgImage,
    required this.clgName,
    required this.clgImageList,
    required this.clgId,
    required this.videoList,
    this.clgType = "N/A",
    this.clgAdd = "N/A",
    this.clgCode = "N/A",
    this.location = "N/A",
    this.collegeStatus = "N/A",
    this.useDefaultImage = false,
  });

  final String clgImage;
  final String clgName;
  final List<dynamic> clgImageList;
  final String clgId;
  final List<dynamic> videoList;
  final String clgType;
  final String clgAdd;
  final String clgCode;
  final String location;
  final String collegeStatus;
  final bool useDefaultImage;

  Widget _buildImage(String imageUrl, bool useDefaultImage) {
    if (useDefaultImage) {
      return Image.asset(
        'assets/image/clg_image.jpg',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print("Error loading default image: $error");
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: Text(
                'No Image',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          );
        },
      );
    } else if (imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print("Error loading network image: $error");
          return Image.asset(
            'assets/image/clg_image.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    'No Image',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              );
            },
          );
        },
      );
    } else {
      return Image.asset(
        'assets/image/clg_image.jpg',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: Text(
                'No Image',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("current location == $location");
    log("current college location $location");
    return Column(
      children: [
        CollegeImageWidget(
          clgImage: clgImage,
          clgImageList: clgImageList,
          clgId: clgId,
          useDefaultImage: useDefaultImage,
        ),
        CollegeBasicDetailWidget(
          clgName: clgName,
          clgId: clgId,
          clgAdd: clgAdd,
          clgType: clgType,
          clgCode: clgCode,
          location: location,
          collegeStatus: collegeStatus,
        ),
        PlayListWidget(clgId: clgId, videoList: videoList),
      ],
    );
  }
}

class CollegeImageWidget extends StatefulWidget {
  const CollegeImageWidget({
    super.key,
    required this.clgImage,
    required this.clgImageList,
    required this.clgId,
    this.useDefaultImage = false,
  });

  final String clgImage;
  final List<dynamic> clgImageList;
  final String clgId;
  final bool useDefaultImage;

  @override
  State<CollegeImageWidget> createState() => _CollegeImageWidgetState();
}

class _CollegeImageWidgetState extends State<CollegeImageWidget> {
  int currentIndex = 0;

  Widget _buildImage(String imageUrl, bool useDefaultImage) {
    if (useDefaultImage) {
      return Image.asset(
        'assets/image/clg_image.jpg',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: Text(
                'No Image',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          );
        },
      );
    } else if (imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/image/clg_image.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    'No Image',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              );
            },
          );
        },
      );
    } else {
      return Image.asset(
        'assets/image/clg_image.jpg',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: Text(
                'No Image',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 330,
          width: MediaQuery.of(context).size.width,
          child: _buildImage(widget.clgImage, widget.useDefaultImage),
        ),
        Positioned(
            bottom: 13.h,
            left: 30.w,
            child: GestureDetector(
              onTap: () {
                Get.to(GalleryViewScreen(
                  clgId: widget.clgId,
                ));
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_rounded,color:grey128Color,size: 25,),
                    Text(
                      "Gallery",
                      style: TextStyle(
                        color: grey128Color,
                        fontSize: 10, // Adjust font size as needed
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Positioned(
          bottom: 22.h,
          right: 30.w,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                CommonFunction.kNavigatorPush(
                  context,
                  ShowImageScreen(
                      clgId: widget.clgId, clgImageList: widget.clgImageList),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
                child: Row(
                  children: [
                    Image.asset(
                      AssetIcons.TAKE_A_TOUR_ICON,
                      height: 15.h,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "Take a Tour",
                      style: TextStyle(
                        color: grey128Color,
                        fontSize: 11.sp,
                        fontFamily: "Poppins",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

// @override
// void dispose() {
//   Future.delayed(Duration.zero, () {
//     kCollegeController.showTabBar.value = true;
//   });
//   log(name: "123", kCollegeController.showTabBar.value.toString());

//   super.dispose();
// }
}

class CollegeBasicDetailWidget extends StatefulWidget {
  const CollegeBasicDetailWidget({
    super.key,
    required this.clgName,
    required this.clgId,
    this.clgType = "N/A",
    this.clgAdd = "N/A",
    this.clgCode = "N/A",
    this.location = "N/A",
    this.collegeStatus = "N/A",
  });

  final String clgName;
  final String clgId;
  final String clgType;
  final String clgAdd;
  final String clgCode;
  final String location;
  final String collegeStatus;

  @override
  State<CollegeBasicDetailWidget> createState() => _CollegeBasicDetailWidgetState();
}

class _CollegeBasicDetailWidgetState extends State<CollegeBasicDetailWidget> {
  List<dynamic> reviewStar = [];

  double calculateAverageReviewStar() {
    if (reviewStar.isEmpty) {
      return 0.0;
    }
    double totalStars = 0.0;
    for (var review in reviewStar) {
      totalStars += double.parse(review["data"]["reviewStar"].toString());
    }
    return totalStars / reviewStar.length;
  }

  // for find current location in map...
  void _openLocationInMaps() async {
    if (await canLaunch(widget.location)) {
      await launch(widget.location);
    } else {
      throw 'Could not launch ${widget.location}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ReviewsApi.getReviewsApi(widget.clgId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("This is am error:"),
              );
            } else if (snapshot.hasData) {
              reviewStar = snapshot.data!;
              // print("review star data == $reviewStar");
              // print("total rating == ${reviewStar[0]["totalReview"]}");
            }
          }
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kPrimaryColor,
                  Color.fromRGBO(157, 123, 194, 1),
                ],
                stops: [0.0, 1.0],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.topRight,
                tileMode: TileMode.repeated,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 1.5.h, horizontal: 5.5.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(widget.collegeStatus ==  "Verified" ?
                        AssetIcons.PROTECT_GREEN_ICON  : AssetIcons.PROTECT_RED_ICON,
                            height: 10.h),
                        SizedBox(width: 3.h),
                        Text(
                          widget.collegeStatus,
                          style: TextStyle(
                            color: widget.collegeStatus ==  "Verified" ? Colors.green : Colors.red,
                            fontSize: 9.sp,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.clgName,
                    // "Sindhu Womens College",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      RateInStarWidget(
                        iconSize: 20,
                        reviewStar: calculateAverageReviewStar().toString(),
                      ),
                      Text(
                        " ${calculateAverageReviewStar().toStringAsFixed(1)} (${reviewStar.length.toString()} ratings)",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        "Admissions",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 5.5.w),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4.5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Open",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        "${widget.clgType} college",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        "SC code- ${widget.clgCode}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const CommonDivider(),
                  SizedBox(height: 10.h),
                  Text(
                    // "Pillar no-254, Rethibowli, Mehdipatnam",
                    widget.clgAdd,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Image.asset(AssetIcons.SMALL_LOCATION_ICON, height: 10.h),
                      SizedBox(width: 2.w),
                      Text(
                        "05 km",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 10.w),
                      InkWell(
                        onTap: _openLocationInMaps,
                        child: Text(
                          "View on map",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class PlayListWidget extends StatelessWidget {
  const PlayListWidget(
      {super.key, required this.clgId, required this.videoList});

  final String clgId;
  final List<dynamic> videoList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: () {
          CommonFunction.kNavigatorPush(
            context,
            TeachingVideoListScreen(clgId: clgId, videoList: videoList),
          );
        },
        child: Row(
          children: [
            SizedBox(width: 40.w),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "A Word from Management",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20.h,
                    child: Row(
                      children: [
                        Text("& ",
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500)),
                        const Expanded(child: CommonDivider()),
                      ],
                    ),
                  ),
                  Text(
                    "Teaching Demo Videos",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(width: 30.w),
            // Image.asset(AssetIcons.VIDEO_IMAGE, height: 100.h),
            YoutubeImageWidget(videoList: videoList),
            SizedBox(width: 30.w),
          ],
        ),
      ),
    );
  }
}
