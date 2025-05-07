import 'package:get/get.dart';
import '../services/college_data_service.dart';

class CollegeController extends GetxController {
  final CollegeDataService _dataService = CollegeDataService();
  
  final RxMap<String, dynamic> collegeData = <String, dynamic>{}.obs;
  final RxList<Map<String, dynamic>> collegeList = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> collegeImages = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> subjects = <Map<String, dynamic>>[].obs;
  
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final data = await _dataService.getAllColleges();
      collegeData.value = data;
      
      collegeList.value = (data['college'] as List).cast<Map<String, dynamic>>();
      collegeImages.value = (data['clgimage'] as List).cast<Map<String, dynamic>>();
      subjects.value = (data['subject'] as List).cast<Map<String, dynamic>>();
      
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  List<Map<String, dynamic>> getCollegeImagesById(String collegeId) {
    return collegeImages.where((image) => 
      image["collegeid"] == collegeId
    ).toList();
  }

  Map<String, dynamic>? getCollegeById(String collegeId) {
    try {
      return collegeList.firstWhere(
        (college) => college["collegeid"].toString() == collegeId,
      );
    } catch (e) {
      return null;
    }
  }

  List<Map<String, dynamic>> filterUniqueSubjects() {
    final Set<String> uniqueSubjects = {};
    final List<Map<String, dynamic>> uniqueSubjectList = [];

    for (final subject in subjects) {
      final subjectName = subject["subjectname"] as String;
      if (!uniqueSubjects.contains(subjectName)) {
        uniqueSubjects.add(subjectName);
        uniqueSubjectList.add(subject);
      }
    }

    return uniqueSubjectList;
  }

  String getValue(dynamic value) => _dataService.getValue(value);
} 