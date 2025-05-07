import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../module/college/view/screen/college_detail_screen.dart';
import '../../services/college_data_service.dart';

class NavigationUtils {
  static Future<void> navigateToCollegeDetail(String collegeId, bool qrFlag) async {
    try {
      final dataService = CollegeDataService();
      final data = await dataService.getAllColleges();
      
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
          final firstTiming = timings != null && timings.isNotEmpty ? timings[0] : null;

          Get.offAll(() => CollegeDetailScreen(
            clgName: dataService.getValue(match["collegename"]),
            clgId: dataService.getValue(match["collegeid"]),
            clgAdd: dataService.getValue(match["address"]),
            clgDetails: [collegeList],
            clgImage: dataService.getValue(collegeImages.isNotEmpty ? collegeImages[0]["imageUrl"] : null),
            clgImageList: collegeImages,
            policy: dataService.getValue(dataService.findByCollegeId(policy, match["collegeid"], "terms_condition")),
            eligibility: dataService.getValue(dataService.findByCollegeId(eligibility, match["collegeid"], "eligibility_criteria")),
            feeTerms: dataService.getValue(dataService.findByCollegeId(eligibility, match["collegeid"], "fee_terms")),
            staffList: staff,
            safety: dataService.getValue(dataService.findByCollegeId(safety, match["collegeid"], "safety_security")),
            courseDetails: subject.where((s) => s["collegeid"] == match["collegeid"]).toList(),
            socialDetails: socialMedia.where((s) => s["collegeid"] == match["collegeid"]).toList(),
            open: dataService.getValue(firstTiming?["open"]),
            close: dataService.getValue(firstTiming?["close"]),
            days: dataService.getValue(firstTiming?["Mon_to_Sat"]),
            description: dataService.getValue(match["Description"]),
            more_info: dataService.getValue(match["more_info"]),
            history: dataService.getValue(match["History_Achievements"]),
            videoList: videos.where((v) => v["collegeid"] == match["collegeid"]).toList(),
            webSiteLink: dataService.getValue(dataService.findByCollegeId(socialMedia, match["collegeid"], "website")),
            clgType: dataService.getValue(match["college_type"]),
            systemType: dataService.getValue(match["system_type"]),
            academicType: dataService.getValue(match["academic_type"]),
            affiliated: dataService.getValue(match["affiliated"]),
            classType: dataService.getValue(match["class_type"]),
            classrooms: dataService.getValue(match["class_rooms"]),
            totalSeats: dataService.getValue(match["total_seats"]),
            totalFloors: dataService.getValue(match["no_of_floors"]),
            totalArea: dataService.getValue(match["college_area"]),
            clgCode: dataService.getValue(match["college_code"]),
            location: dataService.getValue(match["location"]),
            collegeStatus: dataService.getValue(match["collegeStatus"]),
          ));
        }
      }
    } catch (e) {
      print("Error navigating to college detail: $e");
      // Show error dialog or snackbar
      Get.snackbar(
        'Error',
        'Unable to load college details. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
