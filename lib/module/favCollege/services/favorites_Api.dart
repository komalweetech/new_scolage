import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../utils/StudentDetails.dart';
import '../../../utils/apiData/api_base_port.dart';
import '../../../utils/theme/common_color.dart';


class FavoriteApi {
  static postApi(String collegeId, String studentId) async {
    try {
      print("favorite collegeId = $collegeId");
      print("favorite studentId = $studentId");

      var body = jsonEncode(<String, String>{
        "collegeid": collegeId,
        "studentid": studentId,
      });

      print("Request body: $body");
      // var response = await http.post(Uri.parse("https://backend.scolage.com/v2/favouriteclg/post"),
          var response = await http.post(Uri.parse("${ApiBasePort.apiBaseUrl}/v2/favouriteclg/post"),
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      print("Response status code: ${response.statusCode}");
      print("favorite College  response === ${response.body}");

      // var json = jsonEncode(response.body);
      print("auth data is here");
      print(json);

      // print("==================$jsonData");
      print("--------------------------->>>>>${response.statusCode}");

      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData["message"] == "success") {
        Fluttertoast.showToast(
            msg: "college Add in your favorite collegeList",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print("favorite json data == $jsonData");

        return jsonData;
      } else {
        Fluttertoast.showToast                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               (
          msg: "College is already added to favorites",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor:kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      // return json;

    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static getApi() async {
    String studentId = StudentDetails.studentId;
    print("student id 111111112 == $studentId");

    try {
      print("in get api");

      // var apiUrl = await http.get(Uri.parse('https://backend.scolage.com/v2/favouriteclg/get/${StudentDetails.studentId}'));
      var apiUrl = await http.get(Uri.parse('${ApiBasePort.apiBaseUrl}/v2/favouriteclg/get/${StudentDetails.studentId}'));
      final jsonData = await jsonDecode(apiUrl.body) ;
      print("your favorite college get data  ==== $jsonData");
      if(jsonData["status"] == "success"){
        if(jsonData.containsKey("data")) {
          List<dynamic> favoriteData =  jsonData["data"];
          print("get favorite Data = ${favoriteData}");
          print("favorite college list length == ${favoriteData.length}");

          return favoriteData;

        }else {
          throw Exception('Data key not found in API response');
        }
      }else {
        throw Exception('Data key not found in success response');
      }
    } catch (e) {
      print("====$e");
      throw Exception('Error: $e');
    }
  }

  static deleteApi(String collegeId, String studentId) async {
    try {
      print("favorite collegeId = $collegeId");
      print("favorite studentId = $studentId");

      var body = jsonEncode(<String, String>{
        "collegeid": collegeId,
        "studentid": studentId,
      });

      print("Request body: $body");
      // var response = await http.delete(Uri.parse("https://backend.scolage.com/v2/favouriteclg/remove"),
          var response = await http.delete(Uri.parse("${ApiBasePort.apiBaseUrl}/v2/favouriteclg/remove"),

        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      print("Response status code: ${response.statusCode}");
      print("favorite College  response === ${response.body}");

      // var json = jsonEncode(response.body);
      print("Delete api in Favorite List");
      print(json);

      // print("==================$jsonData");
      print("--------------------------->>>>>${response.statusCode}");

      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData["status"] == "success") {
        Fluttertoast.showToast(
            msg: "Favorite college removed successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print("Delete favorite json data == $jsonData");

        return jsonData;
      } else {
        Fluttertoast.showToast                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               (
          msg: "Favorite college not removed please try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      // return json;
    } catch (e) {
      print("Error in deleteApi: $e");
      Fluttertoast.showToast(
        msg: "Error in deleteApi: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }
}
