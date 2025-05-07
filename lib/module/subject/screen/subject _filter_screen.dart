import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/commonWidget/keyboard_off.dart';
import '../../dashboard/view/widget/simple_common_appbar.dart';
import '../../home/services/ClgListApi.dart';
import '../../home/view/widget/college_card.dart';

// class SubjectFilterScreen extends StatefulWidget {
//   const SubjectFilterScreen({super.key,required this.collegeId,required this.subjectName});
//   final String collegeId;
//   final String subjectName;
//
//
//
//   @override
//   State<SubjectFilterScreen> createState() => _SubjectFilterScreenState();
// }
//
// class _SubjectFilterScreenState extends State<SubjectFilterScreen> {
//
//   List<dynamic> subFilterList = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print("college id for  select Subject == ${widget.collegeId}");
//     print("show select subject name == ${widget.subjectName}");
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: PreferredSize(
//         preferredSize:
//         Size.fromHeight(100 + MediaQuery.of(context).padding.top),
//         child: const SimpleCommonAppBar(),
//       ),
//       body:KeyBoardOff(
//         child: FutureBuilder(
//           future: ClgListApi.getAttApi(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.hasError) {
//                 return const Center(
//                   child: Text("there is an error for drawer favorite screen"),
//                 );
//               } else if (snapshot.hasData) {
//                 var data = snapshot.data as Map<dynamic, dynamic>;
//                 var collegeList = data["college"] as List<dynamic>;
//                 var infraOfCollages = data["infra"] as List<dynamic>;
//                 var clgImage = data["clgimage"] as List<dynamic>;
//                 print("college image url ===  ${clgImage.length}");
//                 var policy = data["clgpolicySocialMedia"] as List<dynamic>;
//                 var eligibility = data["feeStructure"] as List<dynamic>;
//                 var staff = data["management_staff"] as List<dynamic>;
//                 var safety = data["highlight"] as List<dynamic>;
//                 var subjects = data["subject"] as List<dynamic>;
//                 var socialMedia = data["clgpolicySocialMedia"] as List<dynamic>;
//                 var videos = data["videoUrl"] as List<dynamic>;
//
//                 print("object college list === $collegeList");
//
//                 // for filter Subject college card show..
//                 for(int i = 0; i < subjects.length; i++) {
//                   if(widget.subjectName.toString() == subjects[i]["subjectname"].toString()){
//                     subFilterList.add(subjects[i]);
//
//                   }
//                 }
//
//                 print("subject filter list = $subFilterList}");
//                 print(" subject filter list length == ${subFilterList.length}");
//                 print("final filter list == ${widget.subjectName}");
//                 print("select subject college id == ${widget.collegeId}");
//
//
//                 return ListView.separated(
//                   shrinkWrap: true,
//                   padding: EdgeInsets.only(left: 20.w, right: 20.w,top: 10.h,bottom: 20.h),
//                   itemCount: subFilterList.length,
//                   itemBuilder: (context, index) {
//
//                     return CollegeCard(
//                       index: index,
//                       height: 200.h,
//                       width: double.infinity,
//                       clgName: collegeList[index]?["collegename"] ?? "N/A",
//                       clgId: collegeList[index]?["collegeid"] ?? "N/A",
//                       clgAdd: collegeList[index]?["address"] ?? "N/A",
//                       clgDetails: [collegeList],
//                       clgImage: clgImage[index]?["imageUrl"] ?? "N/A",
//                       clgImageList: clgImage,
//                       policy: policy[index]?["terms_condition"] ?? "N/A",
//                       eligibility: eligibility[index]?["eligibility_criteria"] ??  "N/A",
//                       staffList: staff,
//                       safety: safety[index]?["safety_security"] ?? "N/A",
//                       subjectName: subjects,
//                       socialMedia: socialMedia,
//                       open: collegeList[index]["timings"][0]["open"]?? "N/A",
//                       close:  collegeList[index]["timings"][0]["close"]?? "N/A",
//                       days:  collegeList[index]["timings"][0]["Mon_to_Sat"]?? "N/A",
//                       description: collegeList[index]["Description"] ?? "N/A",
//                       more_info: collegeList[index]["more_info"] ?? "N/A",
//                       history: collegeList[index]["History_Achievements"] ?? "N/A",
//                       videoList: videos,
//                       webSiteLink: socialMedia[index]["website"]  ?? "N/A",
//
//                       // college Details Screen Data...
//                       clgType: collegeList[index]["college_type"]?? "N/A",
//                       academicType: collegeList[index]["academic_type"]?? "N/A",
//                       affiliated: collegeList[index]["affiliated"]?? "N/A",
//                       classType: collegeList[index]["class_type"]?? "N/A",
//                       classrooms: collegeList[index]["class_rooms"].toString(),
//                       totalSeats: collegeList[index]["total_seats"].toString(),
//                       totalFloors: collegeList[index]["no_of_floors"].toString(),
//                       totalArea: collegeList[index]["college_area"].toString(),
//                       clgCode: collegeList[index]["college_code"].toString(),
//                       location: collegeList[index]["location"].toString(),
//
//                     );
//
//                     },
//                   separatorBuilder: (context, index) =>
//                       SizedBox(height: 20.h),
//                 );
//               }
//             }
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       )
//     );
//
//   }
// }



class SubjectFilterScreen extends StatefulWidget {
  const SubjectFilterScreen({super.key,required this.collegeId,required this.subjectName,});
  final String collegeId;
  final String subjectName;



  @override
  State<SubjectFilterScreen> createState() => _SubjectFilterScreenState();
}

class _SubjectFilterScreenState extends State<SubjectFilterScreen> {

  List<dynamic> subFilterList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("college id for  select Subject == ${widget.collegeId}");
    print("show select subject name == ${widget.subjectName}");
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(100 + MediaQuery.of(context).padding.top),
          child: const SimpleCommonAppBar(),
        ),
        body:KeyBoardOff(
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
                  var subjects = data["subject"] as List<dynamic>;
                  var socialMedia = data["clgpolicySocialMedia"] as List<dynamic>;
                  var videos = data["videoUrl"] as List<dynamic>;

                  print("object college list === $collegeList");

                  // Clear the subFilterList before filtering
                  subFilterList.clear();

                  // Iterate over the subjects and filter the colleges
                  for(int i = 0; i < subjects.length; i++) {
                    if(widget.subjectName.toString() == subjects[i]["subjectname"].toString()){
                      var collegeId = subjects[i]["collegeid"];
                      var college = collegeList.firstWhere((college) => college["collegeid"] == collegeId, orElse: () => null);
                      if(college != null) {
                        subFilterList.add(college);
                      }
                    }
                  }

                  print("subject filter list = $subFilterList}");
                  print(" subject filter list length == ${subFilterList.length}");
                  print("final filter list == ${widget.subjectName}");
                  print("select subject college id == ${widget.collegeId}");


                  return ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 20.w, right: 20.w,top: 10.h,bottom: 20.h),
                    itemCount: subFilterList.length,
                    itemBuilder: (context, index) {
                      var college = subFilterList[index];
                      var collegeId = college["collegeid"];


                      // Find the index of the college image corresponding to the current college
                      var imageIndex = clgImage.indexWhere((image) => image["collegeid"] == collegeId);
                      // Use a default image URL if the image is not found
                      var imageUrl = imageIndex != -1 ? clgImage[imageIndex]["imageUrl"] : "N/A";
                      // Determine if default image should be used
                      bool useDefaultImage = imageUrl == "N/A" || imageUrl.isEmpty;

                      // --- Find matching related data using collegeId ---
                      final matchingPolicy = policy.firstWhere(
                              (p) => p["collegeid"] == collegeId,
                          orElse: () => {"terms_condition": "N/A"}
                      );

                      final matchingEligibility = eligibility.firstWhere(
                              (e) => e["collegeid"] == collegeId,
                          orElse: () => {"eligibility_criteria": "N/A", "fee_terms": "N/A"}
                      );

                      final matchingSafety = safety.firstWhere(
                              (s) => s["collegeid"] == collegeId,
                          orElse: () => {"safety_security": "N/A"}
                      );

                      final matchingSocialMedia = socialMedia.firstWhere(
                              (s) => s["collegeid"] == collegeId,
                          orElse: () => {"website": "N/A"}
                      );

                      // Safely get timings
                      final timings = college["timings"] as List?;
                      final firstTiming = timings != null && timings.isNotEmpty ? timings[0] : null;

                      return CollegeCard(
                        index: index,
                        height: 200.h,
                        width: double.infinity,
                        clgName: college["collegename"] ?? "N/A",
                        clgId: college["collegeid"] ?? "N/A",
                        clgAdd: college["address"] ?? "N/A",
                        clgDetails: [college], // Pass the specific college details
                        clgImage: imageUrl,
                        useDefaultImage: useDefaultImage, // Pass the flag
                        clgImageList: clgImage.where((img) => img["collegeid"] == collegeId).toList(), // Pass filtered images
                        policy: matchingPolicy["terms_condition"] ?? "N/A",
                        eligibility: matchingEligibility["eligibility_criteria"] ??  "N/A",
                        feeTerms: matchingEligibility["fee_terms"] ?? "N/A",
                        staffList: staff.where((s) => s["collegeid"] == collegeId).toList(), // Pass filtered staff
                        safety: matchingSafety["safety_security"] ?? "N/A",
                        subjectName: subjects.where((sub) => sub["collegeid"] == collegeId).toList(), // Pass filtered subjects
                        socialMedia: socialMedia.where((sm) => sm["collegeid"] == collegeId).toList(), // Pass filtered social media
                        open: firstTiming?["open"] ?? "N/A",
                        close: firstTiming?["close"] ?? "N/A",
                        days: firstTiming?["Mon_to_Sat"] ?? "N/A",
                        description: college["Description"] ?? "N/A",
                        more_info: college["more_info"] ?? "N/A",
                        history: college["History_Achievements"] ?? "N/A",
                        videoList: videos.where((vid) => vid["collegeid"] == collegeId).toList(), // Pass filtered videos
                        webSiteLink: matchingSocialMedia["website"] ?? "N/A",

                        // college Details Screen Data... ensure safe access and null checks
                        clgType: college["college_type"] ?? "N/A",
                        systemType: college["system_type"] ?? "N/A", // Added systemType
                        academicType: college["academic_type"] ?? "N/A",
                        affiliated: college["affiliated"] ?? "N/A",
                        classType: college["class_type"] ?? "N/A",
                        classrooms: college["class_rooms"]?.toString() ?? "N/A",
                        totalSeats: college["total_seats"]?.toString() ?? "N/A",
                        totalFloors: college["no_of_floors"]?.toString() ?? "N/A",
                        totalArea: college["college_area"]?.toString() ?? "N/A",
                        clgCode: college["college_code"]?.toString() ?? "N/A",
                        location: college["location"]?.toString() ?? "N/A",
                        collegeStatus: college["collegeStatus"]?.toString() ?? "N/A", // Use ?.toString() for safety
                      );

                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 20.h),
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
