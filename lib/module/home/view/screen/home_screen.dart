// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
import '../../../college/view/screen/college_detail_screen.dart';
import '../../services/ClgListApi.dart';
import '../widget/callege_category_card.dart';
import '../widget/college_card.dart';
import '../widget/nearby_story_button.dart';

import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  final String? collageId;
  final bool isFromQrScan;
  const HomeScreen({
    super.key, 
    this.collageId,
    this.isFromQrScan = false,
  });

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
    super.initState();
    FavoriteColleges.init();
    print("student id == ${StudentDetails.studentId}");
    kNearbyController.fetchCollegeAreas();
    print("scanner collage id == ${widget.collageId}");
    print("is from QR scan == ${widget.isFromQrScan}");
    
    // We'll handle navigation in the FutureBuilder instead of here
    // This ensures we have the college data before navigating
  }

  // Helper function to find and navigate to the college card
  void _navigateToCollegeCard(BuildContext context, List<dynamic> collegeList) {
    if (widget.collageId == null || !widget.isFromQrScan) return;
    
    print("Looking for college with ID: ${widget.collageId}");
    
    // Find the college in the list
    final collegeIndex = collegeList.indexWhere(
      (college) => college["collegeid"] == widget.collageId
    );
    
    if (collegeIndex >= 0) {
      print("Found college at index: $collegeIndex");
      
      // Get the college data
      final currentCollege = collegeList[collegeIndex];
      
      // Get related data
      final collegeImages = (context.findAncestorStateOfType<_HomeScreenState>()?.snapshot?.data?["clgimage"] as List<dynamic>? ?? [])
          .where((image) => image["collegeid"] == currentCollege["collegeid"])
          .toList();
      
      final policy = (context.findAncestorStateOfType<_HomeScreenState>()?.snapshot?.data?["clgpolicySocialMedia"] as List<dynamic>? ?? []);
      final matchingPolicy = policy.firstWhere(
        (p) => p["collegeid"] == currentCollege["collegeid"],
        orElse: () => {"terms_condition": "N/A"}
      );
      
      final eligibility = (context.findAncestorStateOfType<_HomeScreenState>()?.snapshot?.data?["feeStructure"] as List<dynamic>? ?? []);
      final matchingEligibility = eligibility.firstWhere(
        (e) => e["collegeid"] == currentCollege["collegeid"],
        orElse: () => {"eligibility_criteria": "N/A", "fee_terms": "N/A"}
      );
      
      final safety = (context.findAncestorStateOfType<_HomeScreenState>()?.snapshot?.data?["highlight"] as List<dynamic>? ?? []);
      final matchingSafety = safety.firstWhere(
        (s) => s["collegeid"] == currentCollege["collegeid"],
        orElse: () => {"safety_security": "N/A"}
      );
      
      final socialMedia = (context.findAncestorStateOfType<_HomeScreenState>()?.snapshot?.data?["clgpolicySocialMedia"] as List<dynamic>? ?? []);
      final matchingSocialMedia = socialMedia.firstWhere(
        (s) => s["collegeid"] == currentCollege["collegeid"],
        orElse: () => {"website": "N/A"}
      );
      
      final timings = currentCollege["timings"] as List?;
      final firstTiming = timings != null && timings.isNotEmpty ? timings[0] : null;
      
      final staff = (context.findAncestorStateOfType<_HomeScreenState>()?.snapshot?.data?["management_staff"] as List<dynamic>? ?? []);
      final subject = (context.findAncestorStateOfType<_HomeScreenState>()?.snapshot?.data?["subject"] as List<dynamic>? ?? []);
      final videos = (context.findAncestorStateOfType<_HomeScreenState>()?.snapshot?.data?["videoUrl"] as List<dynamic>? ?? []);
      
      // Navigate to college details
      print("Navigating to college details for: ${currentCollege["collegename"]}");
      CommonFunction.kNavigatorPush(
        context,
        CollegeDetailScreen(
          clgId: currentCollege["collegeid"] ?? "N/A",
          clgName: currentCollege["collegename"] ?? "N/A",
          clgImage: collegeImages.isNotEmpty && collegeImages[0]["imageUrl"] != null 
              ? collegeImages[0]["imageUrl"] 
              : "",
          useDefaultImage: collegeImages.isEmpty || collegeImages[0]["imageUrl"] == null,
          clgDetails: [collegeList],
          policy: matchingPolicy["terms_condition"] ?? "N/A",
          eligibility: matchingEligibility["eligibility_criteria"] ?? "N/A",
          safety: matchingSafety["safety_security"] ?? "N/A",
          courseDetails: subject,
          staffList: staff,
          socialDetails: socialMedia,
          open: firstTiming?["open"] ?? "N/A",
          close: firstTiming?["close"] ?? "N/A",
          days: firstTiming?["Mon_to_Sat"] ?? "N/A",
          clgType: currentCollege["college_type"] ?? "N/A",
          systemType: currentCollege["system_type"] ?? "N/A",
          academicType: currentCollege["academic_type"] ?? "N/A",
          affiliated: currentCollege["affiliated"] ?? "N/A",
          classType: currentCollege["class_type"] ?? "N/A",
          classrooms: currentCollege["class_rooms"]?.toString() ?? "N/A",
          totalSeats: currentCollege["total_seats"]?.toString() ?? "N/A",
          totalFloors: currentCollege["no_of_floors"]?.toString() ?? "N/A",
          totalArea: currentCollege["college_area"]?.toString() ?? "N/A",
          clgCode: currentCollege["college_code"]?.toString() ?? "N/A",
          clgImageList: collegeImages,
          videoList: videos,
          webSiteLink: matchingSocialMedia["website"] ?? "N/A",
          clgAdd: currentCollege["address"] ?? "N/A",
          location: currentCollege["location"]?.toString() ?? "N/A",
          description: currentCollege["Description"] ?? "N/A",
          more_info: currentCollege["more_info"] ?? "N/A",
          history: currentCollege["History_Achievements"] ?? "N/A",
          feeTerms: matchingEligibility["fee_terms"] ?? "N/A",
          collegeStatus: currentCollege['collegeStatus'] ?? "N/A",
        ),
      );
    } else {
      print("College with ID ${widget.collageId} not found in the list");
    }
  }

  // Store snapshot for access in helper methods
  AsyncSnapshot? snapshot;

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

  // Helper function to handle null values
  String getValue(dynamic value) {
    return value?.toString() ?? "NULL";
  }

  @override
  Widget build(BuildContext context) {
    return KeyBoardOff(
      child: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
          future: ClgListApi.getAttApi(),
          builder: (context, AsyncSnapshot asyncSnapshot) {
            // Store snapshot for access in helper methods
            snapshot = asyncSnapshot;
            
            if (asyncSnapshot.connectionState == ConnectionState.done) {
              if (asyncSnapshot.hasError) {
                return Center(
                  child: Text("there is an error for home screen"),
                );
              } else if (!asyncSnapshot.hasData || asyncSnapshot.data == null || (asyncSnapshot.data is Map && (asyncSnapshot.data as Map).isEmpty)) {
                return Center(
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
              } else if (asyncSnapshot.hasData) {
                print("Snapshot data type: ${asyncSnapshot.data.runtimeType}");
                print("Snapshot data content: ${asyncSnapshot.data}");

                var data = asyncSnapshot.data as Map<dynamic, dynamic>;
                var originalCollegeList = data["college"] as List<dynamic>? ?? [];
                
                // If we have a college ID from QR scan, navigate to that college
                if (widget.collageId != null && widget.isFromQrScan) {
                  // Use a post-frame callback to ensure the widget is fully built
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _navigateToCollegeCard(context, originalCollegeList);
                  });
                }
                
                var infraOfCollages = data["infra"] as List<dynamic>? ?? [];
                var clgImage = data["clgimage"] as List<dynamic>? ?? [];
                print("college image url ===  ${clgImage.length}");
                var policy = data["clgpolicySocialMedia"] as List<dynamic>? ?? [];
                var eligibility = data["feeStructure"] as List<dynamic>? ?? [];
                var staff = data["management_staff"] as List<dynamic>? ?? [];
                var safety = data["highlight"] as List<dynamic>? ?? [];
                var subject = data["subject"] as List<dynamic>? ?? [];
                var filteredSubjects = filterUniqueSubjects(subject);
                var videos = data["videoUrl"] as List<dynamic>? ?? [];
                var socialMedia = data["clgpolicySocialMedia"] as List<dynamic>? ?? [];

                print("subject wise list == ${subject.length}");
                print("object college list === $originalCollegeList");
                print("college infra list === $infraOfCollages");

                // Always use the original list
                List<dynamic> displayCollegeList = originalCollegeList;

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
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
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
                                        cityimage: kNearbyController.areaClgImage.isNotEmpty
                                            ? kNearbyController.areaClgImage[adjustedIndex % kNearbyController.areaClgImage.length]
                                            : "assets/image/default.jpg",
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
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        "Handpicked for you",
                        style: TextStyle(fontSize: 16,fontFamily: "Poppins",fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    if (displayCollegeList.isNotEmpty)
                      SizedBox(
                        height: 200.h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          scrollDirection: Axis.horizontal,
                          itemCount: displayCollegeList.length,
                          itemBuilder: (context, index) {
                            final currentCollege = displayCollegeList[index];

                            var collegeImages = clgImage.where((image) => image["collegeid"] == currentCollege["collegeid"]).toList();

                            final matchingPolicy = policy.firstWhere(
                                (p) => p["collegeid"] == currentCollege["collegeid"],
                                orElse: () => {"terms_condition": "N/A"}
                            );

                            final matchingEligibility = eligibility.firstWhere(
                                (e) => e["collegeid"] == currentCollege["collegeid"],
                                orElse: () => {"eligibility_criteria": "N/A", "fee_terms": "N/A"}
                            );
                            
                            final matchingSafety = safety.firstWhere(
                                (s) => s["collegeid"] == currentCollege["collegeid"],
                                orElse: () => {"safety_security": "N/A"}
                            );

                             final matchingSocialMedia = socialMedia.firstWhere(
                                (s) => s["collegeid"] == currentCollege["collegeid"],
                                orElse: () => {"website": "N/A"}
                            );

                            final timings = currentCollege["timings"] as List?;
                            final firstTiming = timings != null && timings.isNotEmpty ? timings[0] : null;

                            return CollegeCard(
                              index: index,
                              height: 200.h,
                              width: 300.w,
                              clgName: currentCollege["collegename"] ?? "N/A",
                              clgId: currentCollege["collegeid"] ?? "N/A",
                              clgAdd: currentCollege["address"] ?? "N/A",
                              clgDetails: [displayCollegeList],
                              clgImage: collegeImages.isNotEmpty && collegeImages[0]["imageUrl"] != null 
                                  ? collegeImages[0]["imageUrl"] 
                                  : "", // Empty string to indicate no image URL
                              useDefaultImage: collegeImages.isEmpty || collegeImages[0]["imageUrl"] == null, // Flag to use default asset image
                              clgImageList: collegeImages,
                              policy: matchingPolicy["terms_condition"] ?? "N/A",
                              eligibility: matchingEligibility["eligibility_criteria"] ?? "N/A",
                              feeTerms: matchingEligibility["fee_terms"] ?? "N/A",
                              staffList: staff,
                              safety: matchingSafety["safety_security"] ?? "N/A",
                              subjectName: subject,
                              socialMedia: socialMedia,
                              open: firstTiming?["open"] ?? "N/A",
                              close: firstTiming?["close"] ?? "N/A",
                              days: firstTiming?["Mon_to_Sat"] ?? "N/A",
                              description: currentCollege["Description"] ?? "N/A",
                              more_info: currentCollege["more_info"] ?? "N/A",
                              history: currentCollege["History_Achievements"] ?? "N/A",
                              videoList: videos,
                              webSiteLink: matchingSocialMedia["website"] ?? "N/A",
                              clgType: currentCollege["college_type"] ?? "N/A",
                              systemType: currentCollege["system_type"] ?? "N/A",
                              academicType: currentCollege["academic_type"] ?? "N/A",
                              affiliated: currentCollege["affiliated"] ?? "N/A",
                              classType: currentCollege["class_type"] ?? "N/A",
                              classrooms: currentCollege["class_rooms"]?.toString() ?? "N/A",
                              totalSeats: currentCollege["total_seats"]?.toString() ?? "N/A",
                              totalFloors: currentCollege["no_of_floors"]?.toString() ?? "N/A",
                              totalArea: currentCollege["college_area"]?.toString() ?? "N/A",
                              clgCode: currentCollege["college_code"]?.toString() ?? "N/A",
                              location: currentCollege["location"]?.toString() ?? "N/A",
                              collegeStatus: currentCollege['collegeStatus'] ?? "N/A",
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(width: 10.w),
                        ),
                      ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        "College Categories",
                        style: TextStyle(fontSize: 16,fontFamily: "Poppins",fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 14.h),
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
