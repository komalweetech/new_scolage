import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../module/college/view/screen/college_detail_screen.dart';
import '../../module/home/services/ClgListApi.dart';

class NavigationUtils {
  static Future<void> navigateToCollegeDetail(String collegeId) async {
    try {
      final data = await ClgListApi.getAttApi();
      print("Qr code collage detail == $data");

      if (data != null) {
        final collegeList = data["college"] as List<dynamic>? ?? [];
        final clgImage = data["clgimage"] as List<dynamic>? ?? [];
        final policy = data["clgpolicySocialMedia"] as List<dynamic>? ?? [];
        final eligibility = data["feeStructure"] as List<dynamic>? ?? [];
        final staff = data["management_staff"] as List<dynamic>? ?? [];
        final safety = data["highlight"] as List<dynamic>? ?? [];
        final subject = data["subject"] as List<dynamic>? ?? [];
        final videos = data["videoUrl"] as List<dynamic>? ?? [];
        final socialMedia = data["clgpolicySocialMedia"] as List<dynamic>? ?? [];

        final match = collegeList.firstWhere(
              (clg) => clg["collegeid"].toString() == collegeId,
          orElse: () => null,
        );

        if (match != null) {
          final collegeImages = clgImage
              .where((image) => image["collegeid"] == match["collegeid"])
              .toList();

          final timings = match["timings"] as List<dynamic>?;
          final firstTiming = (timings != null && timings.isNotEmpty) ? timings[0] : null;

          String getValue(dynamic value) {
            return (value == null || value.toString().trim().isEmpty || value == "N/A") ? "NULL" : value.toString();
          }

          dynamic findByCollegeId(List list, String key) {
            return list.firstWhere((item) => item["collegeid"] == match["collegeid"], orElse: () => {})[key];
          }

          Get.offAll(() => CollegeDetailScreen(
            clgName: getValue(match["collegename"]),
            clgId: getValue(match["collegeid"]),
            clgAdd: getValue(match["address"]),
            clgDetails: [collegeList],
            clgImage: getValue(collegeImages.isNotEmpty ? collegeImages[0]["imageUrl"] : null),
            clgImageList: collegeImages,
            policy: getValue(findByCollegeId(policy, "terms_condition")),
            eligibility: getValue(findByCollegeId(eligibility, "eligibility_criteria")),
            feeTerms: getValue(findByCollegeId(eligibility, "fee_terms")),
            staffList: staff,
            safety: getValue(findByCollegeId(safety, "safety_security")),
            courseDetails: subject,
            socialDetails: socialMedia,
            open: getValue(firstTiming?["open"]),
            close: getValue(firstTiming?["close"]),
            days: getValue(firstTiming?["Mon_to_Sat"]),
            description: getValue(match["Description"]),
            more_info: getValue(match["more_info"]),
            history: getValue(match["History_Achievements"]),
            videoList: videos,
            webSiteLink: getValue(findByCollegeId(socialMedia, "website")),
            clgType: getValue(match["college_type"]),
            systemType: getValue(match["system_type"]),
            academicType: getValue(match["academic_type"]),
            affiliated: getValue(match["affiliated"]),
            classType: getValue(match["class_type"]),
            classrooms: getValue(match["class_rooms"]),
            totalSeats: getValue(match["total_seats"]),
            totalFloors: getValue(match["no_of_floors"]),
            totalArea: getValue(match["college_area"]),
            clgCode: getValue(match["college_code"]),
            location: getValue(match["location"]),
            collegeStatus: getValue(match["collegeStatus"]),
          ));
        }
      }
    } catch (e) {
      print("Error navigating to college detail: $e");
    }
  }
}
