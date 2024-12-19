

class AllCollegeData {

  static Map<String, dynamic> collegeDataList = {};
  static Map<String, dynamic> collegeBaseDataList = {};

  static List filteredCollegeData = [];
  static String collegeName = "";
  static String collegeId = "";

  // static  fetchData(String collegeId) async {
  //   try {
  //     var jsonData = await ClgListApi.getAttApi();
  //     List<dynamic> infraData = jsonData;
  //    return infraData;
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //   }
  // }
}

class SubjectList {
  static List subjectList = [];
}