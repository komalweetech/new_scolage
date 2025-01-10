import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/commonWidget/common_screen_content_title.dart';
import '../../../../utils/commonWidget/common_sub_screen_app_bar.dart';
import '../../../../utils/commonWidget/keyboard_off.dart';
import 'fav_college_screen.dart';
import '../../../home/services/ClgListApi.dart';
import '../../../home/view/widget/college_card.dart';

class DrawerFavoriteScreen extends StatefulWidget {
  const DrawerFavoriteScreen({super.key});

  @override
  State<DrawerFavoriteScreen> createState() => _DrawerFavoriteScreenState();
}

class _DrawerFavoriteScreenState extends State<DrawerFavoriteScreen> {
  final List<dynamic> favoriteColleges = FavoriteColleges.favorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonSubScreenAppBar(),
      body: KeyBoardOff(
        child: FutureBuilder(
          future: ClgListApi.getAttApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("there is an error for drawer favorite screen"),
                );
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
                var subjectName = data["subject"] as List<dynamic>;
                var socialMedia = data["clgpolicySocialMedia"] as List<dynamic>;
                var videos = data["videoUrl"] as List<dynamic>;

                print("object college list === $collegeList");
                print("favorite College  list === $favoriteColleges");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonScreenContentTitle(
                      title: "Your Fav college",
                    ),
                    SizedBox(height: 30.h,),
                    Padding(
                      padding:  EdgeInsets.only(right: 28),
                      child: Align(
                        alignment: Alignment.topRight,
                        child:Text("${favoriteColleges.length} saved college",style: TextStyle(fontSize: 13),) ,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 20.w, right: 20.w,top: 10.h,bottom: 20.h),
                        itemCount: collegeList.length,
                        itemBuilder: (context, index) {
                          final collegeId = collegeList[index]["collegeid"];
                          final isFavorite = FavoriteColleges.isFavorite(collegeId);
                          if(isFavorite){
                            return CollegeCard(
                              index: index,
                              height: 200.h,
                              width: double.infinity,
                              clgImageList: clgImage,
                              videoList: videos,
                              clgName: collegeList[index]?["collegename"] ?? "N/A",
                              clgId: collegeId,
                              clgAdd: collegeList[index]?["address"] ?? "N/A",
                              clgDetails: [collegeList],
                              clgImage: clgImage[index]?["imageUrl"] ?? "N/A",
                              policy: policy[index]?["terms_condition"] ?? "N/A",
                              // eligibility: eligibility[index]?["eligibility_criteria"] ?? "N/A",
                              // feeTerms: eligibility[index]?["fee_terms"] ?? "N/A",
                              staffList: staff,
                              safety: safety[index]?["safety_security"] ?? "N/A",
                              subjectName: subjectName,
                              socialMedia: socialMedia,
                              open: collegeList[index]["timings"][0]["open"] ?? "N/A",
                              close: collegeList[index]["timings"][0]["close"] ?? "N/A",
                              days: collegeList[index]["timings"][0]["Mon_to_Sat"] ?? "N/A",

                              // college Details Screen Data...
                              clgType: collegeList[index]["college_type"] ?? "N/A",
                              academicType: collegeList[index]["academic_type"] ?? "N/A",
                              affiliated: collegeList[index]["affiliated"] ?? "N/A",
                              classType: collegeList[index]["class_type"] ?? "N/A",
                              classrooms: collegeList[index]["class_rooms"].toString(),
                              totalSeats: collegeList[index]["total_seats"].toString(),
                              totalFloors: collegeList[index]["no_of_floors"].toString(),
                              totalArea: collegeList[index]["college_area"].toString(),
                              clgCode: collegeList[index]["college_code"].toString(),
                              collegeStatus: collegeList[index]["collegeStatus"].toString(),
                            );
                          }else{
                            return const SizedBox();
                          }
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.h),
                      ),
                    ),
                  ],
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      )

    );
  }
}
