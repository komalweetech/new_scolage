// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../utils/StudentDetails.dart';
import '../../../../utils/commonFunction/common_function.dart';
import '../../../../utils/commonWidget/keyboard_off.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../favCollege/view/screen/fav_college_screen.dart';
import '../../../nearby/dependencies/nearby_dependencies.dart';
import '../../../nearby/view/screen/nearby_screen.dart';
import '../../../subject/screen/subject _filter_screen.dart';
import '../../services/ClgListApi.dart';
import '../widget/callege_category_card.dart';
import '../widget/college_card.dart';
import '../widget/nearby_story_button.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      ClgListApi.getAttApi();
      print("student id  1111111==== ${StudentDetails.studentId}");
      print("name ==== ${StudentDetails.name}");
    });
  }

  void navigateToNearbyScreen(BuildContext context, String selectedCity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NearbyScreen(collegeCode: selectedCity),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FavoriteColleges.init();
    print("student id == ${StudentDetails.studentId}");
    kNearbyController.fetchCollegeAreas();
  }

  // for filter Duplicate subject from all subject list..
  List<Map<String, dynamic>> filterUniqueSubjects(List<dynamic> subjectName) {
    Set<String> uniqueSubjects = {};
    List<Map<String, dynamic>> uniqueSubjectList = [];

    subjectName.forEach((subject) {
      String subjectName = subject["subjectname"];
      if (!uniqueSubjects.contains(subjectName)) {
        uniqueSubjects.add(subjectName);
        uniqueSubjectList.add(subject);
      }
    });
    print("filter subject name == $uniqueSubjects");
    print("after filter subject this list create  = ${uniqueSubjectList}");
    print("filter subject List length ==  ${uniqueSubjectList.length}");
    return uniqueSubjectList;
  }

  @override
  Widget build(BuildContext context) {
    return KeyBoardOff(
      child: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
          future: ClgListApi.getAttApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("there is an error for home screen"),
                );
              } else if (snapshot.hasData.toString().isEmpty) {
                Center(
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
                        "No Data available",
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
                        onTap: () {},
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
                );
                print("Any college not found.");
              } else if (snapshot.hasData) {
                var data = snapshot.data as Map<dynamic, dynamic>;
                var collegeList = data["college"] as List<dynamic>;
                var infraOfCollages = data["infra"] as List<dynamic>;
                var clgImage = data["clgimage"] as List<dynamic>;
                print("college image url ===  ${clgImage.length}");
                var policy = data["clgpolicySocialMedia"] as List<dynamic>;
                var eligibility = data["feeStructure"] as List<dynamic>;
                var staff = data["management_staff"] as List<dynamic>;
                var safety = data["highlight"] as List<dynamic>;
                var subject = data["subject"] as List<dynamic>;
                var filteredSubjects = filterUniqueSubjects(subject);
                var videos = data["videoUrl"] as List<dynamic>;
                var socialMedia = data["clgpolicySocialMedia"] as List<dynamic>;

                print("subject wise list == ${subject.length}");
                print("object college list === $collegeList");
                print("college infra list === $infraOfCollages");

                return ListView(
                  children: [
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 08.h),
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              height: 80.h,
                              child: Obx(() {
                                if (kNearbyController.areaList.isEmpty) {
                                  return Center(child: CircularProgressIndicator());
                                }
                                print("area length == ${kNearbyController.areaList}");
                                return ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: kNearbyController.areaList.length + 1,
                                  // itemCount: collegeList.length,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      // return NearbyStoryButton(
                                      //   cityimage:AssetIcons.NEARBY_ICON,
                                      //   backgroundColor: Colors.white,
                                      //   cityName: "NearBy",                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       );
                                      return InkWell(
                                        onTap: () {
                                          CommonFunction.kNavigatorPush(
                                              context,
                                              NearbyScreen(
                                                collegeCode: "Nearby",
                                              ));
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(13),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                BorderRadius.circular(100),
                                              ),
                                              child: Image.asset(
                                                AssetIcons.NEARBY_ICON,
                                                height: 23.h,
                                                width: 23.w,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "Nearby",
                                              style: TextStyle(
                                                  fontSize: 11.sp,fontFamily: "Poppins",fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      final adjustedIndex = index - 1;
                                      return NearbyStoryButton(
                                        // cityimage: kNearbyController.areaClgImage[index],
                                        // cityName: kNearbyController.areaList[index],
                                        cityimage: kNearbyController.areaClgImage.isNotEmpty
                                            ? kNearbyController.areaClgImage[adjustedIndex % kNearbyController.areaClgImage.length]
                                            : "assets/image/default.jpg", // Fallback image
                                        cityName: kNearbyController.areaList[adjustedIndex],
                                      );
                                    }
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 17.w),
                                );
                              }

                              ),
                            ),
                          ),
                          SizedBox(height: 4.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // HANDPICK TITLE
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        "Handpicked for you",
                        style: TextStyle(fontSize: 16,fontFamily: "Poppins",fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    // COLLEGE LIST
                    SizedBox(
                      height: 200.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: collegeList.length,
                        itemBuilder: (context, index) {
                          // Filter images for the current college
                          var collegeImages = clgImage.where((image) => image["collegeid"] == collegeList[index]["collegeid"]).toList();

                          return CollegeCard(
                            index: index,
                            height: 200.h,
                            width: 300.w,
                            clgName: collegeList[index]["collegename"] ?? "N/A",
                            clgId: collegeList[index]["collegeid"] ?? "N/A",
                            clgAdd: collegeList[index]["address"] ?? "N/A",
                            clgDetails: [collegeList],
                            // Check if images exist for the current college
                            clgImage: collegeImages.isNotEmpty ? collegeImages[0]["imageUrl"] : "N/A",
                            // clgImage: clgImage[index]?["imageUrl"] ?? "N/A",
                            clgImageList: collegeImages,
                            policy: policy[index]?["terms_condition"] ?? "N/A",
                            eligibility: eligibility[index]?["eligibility_criteria"] ?? "N/A",
                            feeTerms: eligibility[index]?["fee_terms"] ?? "N/A",
                            staffList: staff,
                            safety: safety[index]?["safety_security"] ?? "N/A",
                            subjectName: subject,
                            socialMedia: socialMedia,
                            open: collegeList[index]["timings"][0]["open"] ?? "N/A",
                            close: collegeList[index]["timings"][0]["close"] ?? "N/A",
                            days: collegeList[index]["timings"][0]["Mon_to_Sat"] ?? "N/A",
                            description: collegeList[index]["Description"] ?? "N/A",
                            more_info: collegeList[index]["more_info"] ?? "N/A",
                            history: collegeList[index]["History_Achievements"] ?? "N/A",
                            videoList: videos,
                            webSiteLink: socialMedia[index]["website"] ?? "N/A",

                            // college Details Screen Data...
                            clgType: collegeList[index]["college_type"] ?? "N/A",
                            systemType: collegeList[index]["system_type"] ?? "N/A",
                            academicType: collegeList[index]["academic_type"] ?? "N/A",
                            affiliated: collegeList[index]["affiliated"] ?? "N/A",
                            classType: collegeList[index]["class_type"] ?? "N/A",
                            classrooms: collegeList[index]["class_rooms"].toString(),
                            totalSeats: collegeList[index]["total_seats"].toString(),
                            totalFloors: collegeList[index]["no_of_floors"].toString(),
                            totalArea: collegeList[index]["college_area"].toString(),
                            clgCode: collegeList[index]["college_code"].toString(),
                            location: collegeList[index]["location"].toString(),
                            collegeStatus: collegeList[index]['collegeStatus']?? "N/A" ,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10.w),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // COLLEGE CATEGORIES TITLE
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        "College Categories",
                        style: TextStyle(fontSize: 16,fontFamily: "Poppins",fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    // COLLEGE CATEGORIES LIST
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: filteredSubjects.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 52,
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return CollegeCategory(
                          courseName: filteredSubjects[index]["subjectname"],
                          description: filteredSubjects[index]["description"],
                          collegeId: filteredSubjects[index]["collegeid"],
                          onTap: () {
                            setState(() {
                              print(
                                  "subject college id = ${filteredSubjects[index]["collegeid"]}");
                            });
                            CommonFunction.kNavigatorPush(
                                context,
                                SubjectFilterScreen(
                                  collegeId: filteredSubjects[index]["collegeid"],
                                  subjectName: filteredSubjects[index]["subjectname"],
                                ));
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }
            }
            return Center(
                child: Shimmer.fromColors(
                    baseColor: kPrimaryColor,
                    highlightColor: Colors.grey,
                    child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
