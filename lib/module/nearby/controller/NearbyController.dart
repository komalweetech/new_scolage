import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../../../utils/apiData/api_base_port.dart';
import '../../../utils/collegedatalist.dart';
import '../../../utils/constant/asset_icons.dart';
import 'package:http/http.dart' as http;

import '../../../utils/enum/nearby_screen_enum.dart';
import '../../home/model/college_data.dart';
import '../../home/model/college_model.dart';
import '../dependencies/nearby_dependencies.dart';
import '../model/infrastructure_model.dart';
import '../service/collage_area.dart';

class NearbyController extends GetxController {
  final CollageArea collageAreaService = CollageArea();

  // CHECK VALUE SELECTED OR NOT IN CHIP LIST
  bool isThisValueSelected(
      {required String value, required List<dynamic> list}) {
    return list.contains(value);
  }



  //! SORT BY
  Rx<SortByEnum?> selectedSortBy = Rx(null);

  RxBool isAllFilter = false.obs;

  RxBool loading = false.obs;
  var clgList = <CollegeData>[].obs;

  RxString selectedFees = "".obs;
  RxList<CollegeModel> filteredColleges = <CollegeModel>[].obs;

  // ! FEES
  // FEES FILTER BOTTOM SHEET
  RxDouble feesRangeStartValue = 10000.0.obs;
  RxDouble feesRangeEndValue = 185000.0.obs;

  RxInt minFee = 10000.obs;
  RxInt maxFee = 185000.obs;

  // SELECTED CHIP LIST
  List<String> selectedFeeRangeChipList = [];

  void selectValueAndDeselectOthers({
    required String value,
    required List<dynamic> list,
    required VoidCallback onTap,
    required VoidCallback onDeselect,
  }) {
    if (list.contains(value)) {
      list.remove(value);
      onDeselect();
    } else {
      list.clear();
      list.add(value);
      onTap();
    }
  }

  // RESET FEES BOTTOM SHEET VALUE
  void clearFeesBottomSheetValue() {
    selectedFeeRangeChipList = [];
    feesRangeStartValue.value = 10000.0;
    feesRangeEndValue.value = 30000.0;
  }

final feesList = AllCollegeData.collegeDataList["subject"] ?? [];
  // final String baseUrl = 'https://test1.scolage.com/';

  Future<CollegeData?> fetchCollegesData() async {
    // final response = await http.get(Uri.parse('https://backend.scolage.com/v2/collegelist/get'));
    final response = await http.get(Uri.parse('${ApiBasePort.apiBaseUrl}/v2/collegelist/get'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = json.decode(response.body);
      print("college data in near  screen == $data");
      return CollegeData.fromJson(data);
    } else {
      throw Exception(
          'Failed to load colleges. Status Code: ${response.statusCode}');
    }
  }

  // ! AREA
  //TODO : Change area list data this is only for testing
  // List<String> areaList = [
  //   // "NearBy",
  //   "Surat",
  //   "Mumbai",
  //   "Rajkot",
  //   "Junagadh",
  //   "Goa",
  //   "Bhavnagar",
  //   "Ahmedabad",
  //   "Bangalore",
  //   "Kanpur",
  //   "Bhopal",
  //   "Nashik",
  //   "Gwalior",
  //   "Raipur",
  // ];

  List<String> areaClgImage = [
    // AssetIcons.NEARBY_ICON,
    "assets/image/surat.jpg",
    "assets/image/mumbai.jpg",
    "assets/image/rajkot.jpg",
    "assets/image/junaghadh.jpg",
    "assets/image/goa.jpg",
    "assets/image/bhavnagar.jpg",
    "assets/image/ahmedabad.jpg",
    "assets/image/bangalore.jpg",
    "assets/image/kanpur.jpg",
    "assets/image/bhopal.jpg",
    "assets/image/nashik.jpg",
    "assets/image/gwalior.jpg",
    "assets/image/raipur.jpg",
  ];
  // LISTS .
  RxList<String>

  displayAreaList = <String>[].obs;
  RxList<String> areaList = <String>[].obs;
  List<String> selectedAreaList = [];
  RxString selectedArea = "".obs;
  RxBool displayAllAreaList = false.obs;


  @override
  void onInit() {
    super.onInit();
    loadCollegeAreas();
  }

  // Get college area list from API
  Future<void> loadCollegeAreas() async {
    try {
      final areas = await collageAreaService.fetchCollegeAreas();
      print("Fetched college areas: $areas");
      areaList.clear();
      areaList.addAll(areas); // Update areaList with API response
      addTop5AreaInDisplayList(); // Call this to add top 5 areas if required
      update(); // Trigger a rebuild to reflect changes
    } catch (e) {
      print("Error loading college areas: $e");
    }
  }

  // INSERT DATA TOP 5 INTO DISPLAY LIST
  void addTop5AreaInDisplayList() {
    displayAreaList.clear();
    if (areaList.length > 5) {
      for (int i = 0; i < 5; i++) {
        displayAreaList.add(areaList[i]);
      }
    }
  }


  // INSERT ALL DATA INTO DISPLAY LIST
  void addAllAreaIntoDisplayAreaList() {
    displayAreaList.clear();
    displayAreaList.addAll(areaList);
  }

  // RESET FEES BOTTOM SHEET VALUE
  void clearAreaBottomSheetValue() {
    selectedAreaList = [];
  }

  // ! TRENDING
  List<String> trendingList = [
    "smartclass",
    "staffroom",
    "auditorium",
    "computerlab",
    "hostel",
    "bustransport",
    "parking",
    "cctv",
    "library",
    "elevator",
    "powerbackup",
    "canteen",
    "medicalsupport",
    "firesafety",
    "emergencyexit",
    "playground"
  ];

  // LISTS .
  RxList<String> displayTrendingList = <String>[].obs;
  List<String> selectedTrendingList = [];
  RxString selectedTrend = "".obs;
  RxBool displayAllTrendingList = false.obs;

  // INSERT DATA TOP 5 INTO DISPLAY LIST
  void addTop5TrendingInDisplayList() {
    displayTrendingList.clear();
    if (trendingList.length > 5) {
      for (int i = 0; i < 5; i++) {
        displayTrendingList.add(
          trendingList[i],
        );
      }
    }
  }

  // INSERT ALL DATA INTO DISPLAY LIST
  void addAllTrendingIntoDisplayTrendingList() {
    displayTrendingList.clear();
    displayTrendingList.addAll(trendingList);
  }

  // RESET FEES BOTTOM SHEET VALUE
  void clearTrendingBottomSheetValue() {
    selectedTrendingList = [];
  }

  // ! INFRASTRUCTURE
  List<InfrastructureModel> infrastructureList = [
    InfrastructureModel(
        name: "Smartclass", icon: AssetIcons.INFRA_SMART_CLASS_ICON),
    InfrastructureModel(name: "Library", icon: AssetIcons.INFRA_LIBRARY_ICON),
    InfrastructureModel(name: "Parking", icon: AssetIcons.INFRA_PARKING_ICON),
    InfrastructureModel(name: "Elevator", icon: AssetIcons.INFRA_ELEVATOR_ICON),
    InfrastructureModel(
        name: "Auditorium", icon: AssetIcons.INFRA_AUDITORIUM_ICON),
    InfrastructureModel(
        name: "Powerbackup", icon: AssetIcons.INFRA_POWER_BACKUP_ICON),
    InfrastructureModel(name: "CCTV", icon: AssetIcons.INFRA_CCTV_ICON),
    InfrastructureModel(
        name: "Computerlab", icon: AssetIcons.INFRA_COMPUTER_LAB_ICON),
    InfrastructureModel(name: "Canteen", icon: AssetIcons.INFRA_CANTEEN_ICON),
    InfrastructureModel(
        name: "Firesafety", icon: AssetIcons.INFRA_FIRE_SAFETY_ICON),
    InfrastructureModel(
        name: "Playground", icon: AssetIcons.INFRA_PLAY_GROUND_ICON),
    InfrastructureModel(
        name: "Medicalsupport", icon: AssetIcons.INFRA_MEDICAL_SUPPORT_ICON),
    InfrastructureModel(
        name: "Bustransport", icon: AssetIcons.INFRA_BUS_TRANSPORT_ICON),
    InfrastructureModel(
        name: "Emergencyexit", icon: AssetIcons.INFRA_EMERGENCY_EXIT_ICON),
  ];

  // LISTS .
  List<InfrastructureModel> selectedInfrastructureList = [];

  // RESET FEES BOTTOM SHEET VALUE
  void clearInfrastructureBottomSheetValue() {
    selectedInfrastructureList = [];
  }

  //! ALL
  void clearAllFilterValue() {
    selectedSortBy.value = null;
    clearFeesBottomSheetValue();
    clearAreaBottomSheetValue();
    clearTrendingBottomSheetValue();
    clearInfrastructureBottomSheetValue();
  }

  List<CollegeModel> applyFilters(
      CollegeData collegeData, String filters) {
    List<CollegeModel> allColleges =
    List<CollegeModel>.from(collegeData.college ?? []);

    if (filters == "Sort") {
      switch (selectedSortBy.value!.displayName) {
        case "popularity":
          filteredColleges.assignAll(allColleges);
          break;
        case "nearby":
          filteredColleges.assignAll(allColleges);
          break;
        case "rating":
          filteredColleges.assignAll(allColleges);
          break;
        case "priceLowToHigh":
          filteredColleges.assignAll(allColleges);
          break;
        case "priceHighToLow":
          filteredColleges.assignAll(allColleges);
          break;
        default:
          filteredColleges.assignAll(allColleges);
          break;
      }
    } else if (filters == "Area") {
      filteredColleges.value = kNearbyController.filterCollegesByAddress(
          allColleges, selectedAreaList.first);
    } else if (filters == "Fees") {
      filteredColleges.value = filterCollegesByFeeRange(
          allColleges, collegeData.subject!, minFee.value, maxFee.value);
    } else if (filters == "Trending") {
      filteredColleges.value = filterCollegesByFacility(allColleges,
          selectedTrendingList.first.toLowerCase(), collegeData.infra!);
    } else {
      filteredColleges.assignAll(allColleges);
    }

    return filteredColleges;
  }

   reloadCollegesData() async {
     print('Reload colleges with filters');

     try {
       // Fetch the college areas before reloading
       final areas = await collageAreaService.fetchCollegeAreas();
       print("Fetched college areas: $areas");

       // Update the observable list
       areaList.value = areas;

       // Use the fetched areas in your logic (if needed)
       print("College areas updated: ${areaList.value}");
     } catch (e) {
       print("Error loading college areas: $e");
     }
    update(); // Trigger a rebuild
  }

  List<CollegeModel> filterCollegesByAddress(
      List<CollegeModel> colleges, String selectedAddress) {
    return colleges
        .where((college) => college.location == selectedAddress)
        .toList();
  }


  List<CollegeModel> filterCollegesByFeeRange(
      List<CollegeModel> colleges,
      List<Subject> subjects,
      int selectedMinFees,
      int selectedMaxFees,
      ) {
    return colleges.where((college) {
      // Check if the subject with the college id exists
      Subject? subject = findSubject(college.collegeid!, subjects);
      if (subject != null) {
        return subject.minFees! >= selectedMinFees &&
            subject.maxFees! <= selectedMaxFees;
      }
      return false;
    }).toList();
  }

  Subject? findSubject(String collegeId, List<Subject> subjects) {
    // Find the subject with the given college id
    return subjects.firstWhere(
          (subject) => subject.collegeid == collegeId,
      orElse: () => Subject(),
    );
  }

  List<CollegeModel> filterCollegesByFacility(
      List<CollegeModel> colleges, String facility, List<Infra> infras) {
    return colleges.where((college) {
      Infra? infra = findInfraForCollege(college, infras);
      return getFacilityValue(infra, facility);
    }).toList();
  }

  Infra findInfraForCollege(CollegeModel college, List<Infra> infras) {
    var matchingInfra = infras.firstWhere(
          (infra) => infra.collegeid == college.collegeid,
      orElse: () => Infra(), // Use a default instance of Infra here
    );

    return matchingInfra;
  }

  bool getFacilityValue(Infra infra, String facility) {
    // Return the value of the selected facility for the given college
    // You can use reflection or a manual if-else check based on the facility name
    switch (facility) {
      case 'smartclass':
        return infra.smartclass ?? false;
      case 'staffroom':
        return infra.staffroom ?? false;
      case 'auditorium':
        return infra.auditorium ?? false;
      case 'computerlab':
        return infra.computerlab ?? false;
      case 'hostel':
        return infra.hostel ?? false;
      case 'bustransport':
        return infra.bustransport ?? false;
      case 'parking':
        return infra.parking ?? false;
      case 'cctv':
        return infra.cctv ?? false;
      case 'library':
        return infra.library ?? false;
      case 'elevator':
        return infra.elevator ?? false;
      case 'powerbackup':
        return infra.powerbackup ?? false;
      case 'canteen':
        return infra.canteen ?? false;
      case 'medicalsupport':
        return infra.medicalsupport ?? false;
      case 'firesafety':
        return infra.firesafety ?? false;
      case 'emergencyexit':
        return infra.emergencyexit ?? false;
      case 'playground':
        return infra.playground ?? false;
      default:
        return false; // Default value if facility name is not recognized
    }
  }

  List<CollegeModel> filterColleges(
      List<CollegeModel> colleges,
      List<Subject>? subjects,
      // String? sortBy,
      List<Infra>? infraList,
      String? selectedArea,
      int? minFee,
      int? maxfee,
      String? selectedFacilities,
      ) {
    return colleges.where((college) {
      return
        // _sortByFilter(college, sortBy?.toLowerCase() ?? '') ||
          _filterByFeeRange(college, subjects!, minFee!, maxfee!) ||
          _filterByFacility(college, infraList!,
              selectedFacilities?.toLowerCase().trim() ?? '') ||
          _filterByArea(college, selectedArea ?? '');
    }).toList();
  }

  bool _sortByFilter(CollegeModel college, String sortBy) {
    // Sorting logic based on sortBy criteria
    switch (sortBy) {
      case 'popularity':
        return true;
      case 'rating':
        return true;
      case 'nearby':
        return true;
      case 'priceLowToHigh':
        return true;
      case 'priceHighToLow':
        return true;
      default:
        return false;
    }
  }

  bool _filterByArea(CollegeModel college, String? selectedArea) {
    return selectedArea == null || college.location == selectedArea;
  }

  bool _filterByFeeRange(
      CollegeModel college,
      List<Subject> subjects,
      int minFee,
      int maxFee,
      ) {
    // Find the subject for the given college
    Subject? subject = findFeesSubject(college.collegeid!, subjects);

    // Check if the subject exists and the fee is within the specified range
    return subject != null &&
        subject.minFees != null &&
        subject.maxFees != null &&
        subject.minFees! >= minFee &&
        subject.maxFees! <= maxFee;
  }

  Subject? findFeesSubject(String collegeId, List<Subject> subjects) {
    // Find the subject with the given college id
    return subjects.firstWhere(
          (subject) => subject.collegeid == collegeId,
      orElse: () => Subject(),
    );
  }

  bool _filterByFacility(
      CollegeModel college,
      List<Infra> infraList,
      String selectedFacility,
      ) {
    Infra? infra = findInfraForCollege(college, infraList);

    return getFacilityValue(infra, selectedFacility);
  }
}
