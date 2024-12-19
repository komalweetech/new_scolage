

import 'package:file_picker/file_picker.dart';

import 'package:get/get.dart';



import '../../../utils/collegedatalist.dart';
import '../../../utils/constant/asset_icons.dart';
import '../../home/services/ClgListApi.dart';
import '../../nearby/model/infrastructure_model.dart';
import '../model/college_detail_model.dart';

class CollegeController extends GetxController {
  var expandCollegeDetail = true.obs;
  var sectionVisibility = List.generate(9, (index) => false.obs).obs;


  void fetchCollegeDetails() async {
    try {
      var jsonData = await ClgListApi.getAttApi(); // Fetching data from API
      List<CollegeDetailModel> newList = []; // Create a new list to hold CollegeDetailModel objects

      // Transform JSON data to CollegeDetailModel objects
      if (jsonData is List) {
        newList = jsonData.map((data) {
          return CollegeDetailModel(
            type: data['type'] ?? '',
            value: data['value'] ?? '',
          );
        }).toList();
      }

      // Update the value of collegeBasicDetailList in the controller
      collegeBasicDetailList = newList;


      // Update the UI using GetX reactive updates if needed
      update();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }


  List<CollegeDetailModel> collegeBasicDetailList = [

    CollegeDetailModel(type: "College Type", value:"${AllCollegeData.collegeDataList["college"][0]["college_type"]}"),
    CollegeDetailModel(type: "Academic Type", value: "${AllCollegeData.collegeDataList["college"][0]["academic_type"]}"),
    CollegeDetailModel(type: "Affiliated", value:"${AllCollegeData.collegeDataList["college"][0]["affiliated"]}"),
    CollegeDetailModel(type: "Type", value:"${ AllCollegeData.collegeDataList["college"][0]["class_type"]}"),
    CollegeDetailModel(type: "Class Rooms", value: "15"),
    CollegeDetailModel(type: "No. of Seats", value: "12,000"),
    CollegeDetailModel(type: "No. of Floors", value: "5"),
    CollegeDetailModel(type: "Total Area", value: "5,000 sft"),
    CollegeDetailModel(type: "College Code", value: "Private"),
  ];


  List<String> tabViewList = [
    "College Detail",
    "Infrastructure",
    "Highlights",
    "Safty & Security",
    "Management & Staff",
    "Subject’s",
    "Social Media",
    "Policy",
    "Review"
  ];
// when tab open this tab's details also open .....
  void expandDetailWhenTapOnTab(int index) {
    sectionVisibility[index].value = !sectionVisibility[index].value;
    if (sectionVisibility[index].value) {
      // Set all other sections to false
      for (int i = 0; i < sectionVisibility.length; i++) {
        if (i != index) {
          sectionVisibility[i].value = false;
        }
      }
    }
  }

  RxBool showTabBar = true.obs;
  RxInt selectedTabInt = 0.obs;

  List<InfrastructureModel> collegeHighlightsList = [
    InfrastructureModel(
        name: "Sport Events", icon: AssetIcons.HIGHLIGHTS_SPOT_EVENTS_ICON),
    InfrastructureModel(
        name: "Skill Development",
        icon: AssetIcons.HIGHLIGHTS_SKILL_DEVELOPMENT_ICON),
    InfrastructureModel(
        name: "Scholarship", icon: AssetIcons.HIGHLIGHTS_SCHOLARSHIP_ICON),
    InfrastructureModel(
        name: "Career Counselling",
        icon: AssetIcons.HIGHLIGHTS_CAREER_COUNSELLING_ICON),
  ];

  // SUBJECT LIST
  List<String> subjectList = [
    "M.P.C",
    "Bi.P.C",
    "C.E.C",
    "M.E.C",
    "M.Bi.P.C",
    "H.E.C"
  ];

  // SOCIAL MEDIA LIST
  List<InfrastructureModel> socialMediaList = [
    InfrastructureModel(name: "Website", icon: AssetIcons.WEBSITE_ICON),
    InfrastructureModel(name: "Facebook", icon: AssetIcons.FACEBOOK_ICON),
    InfrastructureModel(name: "Youtube", icon: AssetIcons.YOUTUBE_ICON),
    InfrastructureModel(name: "Instagram", icon: AssetIcons.INSTAGRAM_ICON),
  ];

  // ADMISSION FOR DATA
    Rx<DateTime?> dateOfBirth = Rx(null);

  // PICKED FILE
  Rx<PlatformFile?> studentPhotoDocument = Rx(null);
  Rx<PlatformFile?> hallTicketDocument = Rx(null);
  Rx<PlatformFile?> adharCardDocument = Rx(null);
  Rx<PlatformFile?> casteCertificateDocument = Rx(null);

  RxBool termsAndConditionRead = false.obs;
  RxBool admissionDetailRead = false.obs;
}
