import '../../home/services/ClgListApi.dart';

class ClgDetailsUtils {
  static List<dynamic> collegeDetailsList = [];
  static List<dynamic> collegeDataList = [];

  // Methods to fetch and store data from ClgListApi
  static Future<void> fetchData() async {
    try {
      var jsonData = await ClgListApi.getAttApi();
      collegeDetailsList = jsonData;
      collegeDataList = jsonData;
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
