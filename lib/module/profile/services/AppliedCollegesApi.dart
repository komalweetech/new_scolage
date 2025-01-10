import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http ;

import '../../../utils/StudentDetails.dart';
import '../../../utils/apiData/api_base_port.dart';



class AppliedCollegesApi {

  static getAppliedApi() async {
    String studentId = StudentDetails.studentId;
    print("student id 111111112 == $studentId");
    try {
      print("in get api");
      // var apiUrl = Uri.https('backend.scolage.com', '/v2/appliedclg/get/${StudentDetails.studentId}');
      var apiUrl =  '${ApiBasePort.apiBaseUrl}/v2/appliedclg/get/${StudentDetails.studentId}';

      print("your uri ==== $apiUrl");

      // var response = await http.get(apiUrl, headers: {
      //   'Cookie':
      //   "jwtToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InZpc2hhbDEyM0BnbWFpbC5jb20iLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTcwMDI5NjY4N30.MUht-jjsMCUwLUZF3h4euwRHZs8uoWD20rvE1NPwodI"
      // });
      var response = await http.get(Uri.parse(apiUrl), headers: {
        'Cookie':
        "jwtToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InZpc2hhbDEyM0BnbWFpbC5jb20iLCJyb2xlIjoic3VwZXJhZG1pbiIsImlhdCI6MTcwMDI5NjY4N30.MUht-jjsMCUwLUZF3h4euwRHZs8uoWD20rvE1NPwodI"
      });
      print("....${response.body}");

      var jsonData = await jsonDecode(response.body)['appliedClgData'];
      print("------$json");

      print("Applied college Data === $jsonData");
      print("--------------------------->>>>>${response.statusCode}");

      return jsonData;
    } catch (e) {
      print("====$e");
      return ["error"];
    }

  }
  // static postApi(String tital) async {
  //   try {
  //     print("in get api");
  //     var attData = await http.get(Uri.parse(
  //         "${ApiBasePort.ApiBase}/v2/apply/clg"));
  //
  //     var jsonData = await jsonEncode(<String, String>{
  //       "tital" = tital,
  //
  //     });
  //     print(json);
  //
  //     print("==================$jsonData");
  //     print("--------------------------->>>>>${attData.statusCode}");
  //
  //     return jsonData;
  //   }catch (e) {
  //     print("====$e");
  //     return ["error"];
  //   }
  // }
}