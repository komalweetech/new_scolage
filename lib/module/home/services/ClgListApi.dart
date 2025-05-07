import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/apiData/api_base_port.dart';
import '../../../utils/collegedatalist.dart';



class ClgListApi {
  static getAttApi() async {
    try {
      print("in get api");
      var attData = await http.get(Uri.parse("${ApiBasePort.apiBaseUrl}/v2/collegelist/get"));

      var jsonData = await jsonDecode(attData.body);
      print(json);
      AllCollegeData.collegeBaseDataList = jsonData;
      AllCollegeData.collegeDataList = jsonData;


      return jsonData;
    } catch (e) {
      print("====$e");
      return ["error"];
    }
  }

  static Future<Map<String, dynamic>?> getSingleCollegeData(String collegeId) async {
    try {
      final response = await http.get(
        Uri.parse("https://api.scolage.com/v2/singlecglist/get/$collegeId"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("College Data: $data");
        return data;
      } else {
        print("Failed to fetch data: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("API error: $e");
      return null;
    }
  }
}





