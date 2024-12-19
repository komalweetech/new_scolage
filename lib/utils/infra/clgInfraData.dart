

import '../../module/home/services/ClgListApi.dart';

class ClgInfraData {
  static List<dynamic> infraData = [];
  static List<dynamic> collegeInfraList = [];

  static Future<void> fetchData() async {
    try {
      var jsonData = await ClgListApi.getAttApi();
      infraData = jsonData;
      collegeInfraList = jsonData;
      print("data === $infraData");
    } catch (e) {
      print("Error fetching data:11111111 $e");
    }
  }
}