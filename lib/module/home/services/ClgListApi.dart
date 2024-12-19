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
}



