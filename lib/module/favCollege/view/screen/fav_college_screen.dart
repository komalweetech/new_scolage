import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/StudentDetails.dart';
import '../../../../utils/commonWidget/keyboard_off.dart';
import '../../../../utils/commonWidget/status_bar_theme.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../home/view/widget/college_card.dart';
import '../../services/favorites_Api.dart';

class FavCollageScreen extends StatefulWidget {
  const FavCollageScreen({Key? key});

  @override
  State<FavCollageScreen> createState() => _FavCollageScreenState();
}

class _FavCollageScreenState extends State<FavCollageScreen> {
  List<dynamic> favoriteData = [];
  Map<String, String> studentDetails = StudentDetails.getDetails();
  String studentId = StudentDetails.studentId;

  // String collegeId = CollegeData.collegeId;

  late Completer<void> _completer;

  Future<void> _refreshData() async {
    _completer = Completer<void>();
    await Future.delayed(Duration(seconds: 2));
    await _loadFavoriteData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completer = Completer<void>();
    _loadFavoriteData();
  }

  Future<void> _loadFavoriteData() async {
    try {
      var data = await FavoriteApi.getApi();
        setState(() {
          favoriteData = data;
          print("show favorite data == $favoriteData");
          print("favorite college length == ${favoriteData.length}");
          // print("favorite == ${favoriteData.first["clgdetail"]["collegename"].toString()}");
        });

    } catch (e) {
      print("Error loading favorite data: $e");
      // Handle the error as needed
    } finally {
      if (!_completer.isCompleted) {
        _completer.complete();
      }
    }
  }

  @override
  void dispose() {
    if (!_completer.isCompleted) {
      _completer.complete();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarTheme(
      value: SystemUiOverlayStyle.dark,
      child: KeyBoardOff(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.sp, bottom: 20.sp),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Your Fav collages",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23.sp,
                      color: Colors.black87,
                      fontFamily: "Poppins"),
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: _refreshData,
              child: FutureBuilder(
                future: _completer.future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            "there is an error for favorite college screen"),
                      );
                    } else if (favoriteData.isNotEmpty) {
                        return ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: 25.w, right: 25.w, top: 10.h, bottom: 20.h),
                          scrollDirection: Axis.vertical,
                          itemCount: favoriteData.length,
                          itemBuilder: (context, index) {
                            print("favorite college == ${favoriteData}");
                            return CollegeCard(
                              index: index,
                              height: 200.h,
                              width: double.infinity,
                              clgImageList: favoriteData[index]["clgimage"],
                              videoList: favoriteData[index]["videoUrl"],
                              clgName: favoriteData[index]["clgdetail"][0]
                              ["collegename"] ??
                                  "N/A",
                              clgId: favoriteData[index]["clgdetail"][0]
                              ["collegeid"] ??
                                  "N/A",
                              clgAdd: favoriteData[index]["clgdetail"][0]
                              ["address"] ??
                                  "N/A",
                              clgDetails: favoriteData[index]["clgdetail"],
                              clgImage: favoriteData[index]["clgimage"][0]
                              ["imageUrl"] ??
                                  "N/A",
                              policy: favoriteData[index]["clgpolicy"][0]
                              ["terms_condition"] ??
                                  "N/A",
                              eligibility: favoriteData[index]["fee_structure"]
                              [0]["eligibility_criteria"] ??
                                  "N/A",
                              feeTerms: favoriteData[index]["fee_structure"][0]
                              ["fee_terms"] ??
                                  "N/A",
                              // feeStructure: favoriteData[index]["feeStructure"],
                              staffList: favoriteData[index]["staff"],
                              safety: favoriteData[index]["highlight"][0]
                              ["safety_security"] ??
                                  "N/A",
                              subjectName: favoriteData[index]["subject"],
                              socialMedia: favoriteData[index]["clgpolicy"],
                              open: favoriteData[index]["clgdetail"][0]
                              ["timings"][0]["open"] ??
                                  "N/A",
                              close: favoriteData[index]["clgdetail"][0]
                              ["timings"][0]["close"] ??
                                  "N/A",
                              days: favoriteData[index]["clgdetail"][0]
                              ["timings"][0]["Mon_to_Sat"] ??
                                  "N/A",
                              description: favoriteData[index]["clgdetail"][0]
                              ["Description"] ??
                                  "N/A",
                              history: favoriteData[index]["clgdetail"][0]
                              ["History_Achievements"] ??
                                  "N/A",
                              more_info: favoriteData[index]["clgdetail"][0]
                              ["more_info"] ??
                                  "N/A",
                              webSiteLink: favoriteData[index]["clgpolicy"][0]
                              ["website"] ??
                                  "N/A",

                              // college Details Screen Data...business
                              clgType: favoriteData[index]["clgdetail"][0]
                              ["college_type"] ??
                                  "N/A",
                              academicType: favoriteData[index]["clgdetail"][0]
                              ["academic_type"] ??
                                  "N/A",
                              affiliated: favoriteData[index]["clgdetail"][0]
                              ["affiliated"] ??
                                  "N/A",
                              classType: favoriteData[index]["clgdetail"][0]
                              ["class_type"] ??
                                  "N/A",
                              classrooms: favoriteData[index]["clgdetail"][0]
                              ["class_rooms"]
                                  .toString(),
                              totalSeats: favoriteData[index]["clgdetail"][0]
                              ["total_seats"]
                                  .toString(),
                              totalFloors: favoriteData[index]["clgdetail"][0]
                              ["no_of_floors"]
                                  .toString(),
                              totalArea: favoriteData[index]["clgdetail"][0]
                              ["college_area"]
                                  .toString(),
                              clgCode: favoriteData[index]["clgdetail"][0]
                              ["college_code"]
                                  .toString(),
                              location: favoriteData[index]["clgdetail"][0]
                              ["location"] ??
                                  "N/A",
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(
                                height: 30.h,
                              ),
                        );
                      } else {
                        return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(height: 30.sp,),
                                Image.asset("assets/icons/no_data_image.png",height: 300.sp,),
                                // SvgPicture.asset(
                                //   'assets/icons/no_data_image.svg',
                                //   height: 250.sp,
                                //   width: 200.sp,
                                // ),
                                SizedBox(height: 70.sp,),
                               Text(
                                 "No favorites yet",
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 23.sp,
                                     color: Colors.black87,
                                     fontFamily: "Poppins"),
                               ),
                               Text(
                                 "Start searching for colleges now",
                                 style: TextStyle(
                                     fontSize: 11.sp,
                                     color: Colors.grey,
                                     fontFamily: "Poppins",
                                     fontWeight: FontWeight.w500),
                               ),
                               SizedBox(height: 15.sp,),
                               ElevatedButton(
                                   style: ElevatedButton.styleFrom(
                                       backgroundColor: Colors.black,
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(
                                             10),

                                       ),
                                       padding: EdgeInsets.symmetric(
                                           horizontal: 25.sp, vertical: 05.sp),
                                       elevation: 0
                                   ),
                                   onPressed: () {},
                                   child: Text("Explore junior colleges",
                                     style: TextStyle(
                                       fontFamily: 'Poppins', // Use your font
                                       fontSize: 14.sp,
                                       color: Colors.white, // Text color
                                       fontWeight: FontWeight
                                           .normal, // Regular font weight
                                     ),))
                              ],
                            ));

                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteColleges {
  static List<String> favorites = [];

  static Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favorites = prefs.getStringList("favorites") ?? [];
  }

  static void toggleFavorite(String collegeId) async {
    if (favorites.contains(collegeId)) {
      // College remove in Favorite screen.
      favorites.remove(collegeId);
    } else {
      // College add in Favorite screen.
      favorites.add(collegeId);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favorites);
  }

  static bool isFavorite(String collegeId) {
    return favorites.contains(collegeId); // Check if college is favorite
  }
// static void setFavoriteAtIndex(int index, List<dynamic> favoriteCollegeList){
//   if (index >= 0 && index < favoriteCollegeList.length) {
//     String collegeId = favoriteCollegeList[index]?["collegeid"] ?? ""; // Get college ID at the specified index
//     toggleFavorite(collegeId); // Toggle favorite status based on the college ID
//   }
// }
}
