import '../../module/home/services/ClgListApi.dart';

class ClgData {
  static List<dynamic> collegeBaseDataList = [];
  static List<dynamic> collegeDataList = [];

  // Methods to fetch and store data from ClgListApi
  static Future<void> fetchData() async {
    try {
      var jsonData = await ClgListApi.getAttApi();
      collegeBaseDataList = jsonData;
      collegeDataList = jsonData;
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
