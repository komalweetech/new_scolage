import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/apiData/api_base_port.dart';
import '../../../utils/theme/common_color.dart';


class ReviewsApi {
  static Future<List<dynamic>> getReviewsApi (String collegeId) async {
    try {
      print("in get api");
      // var attData = await http.get(Uri.parse("https://backend.scolage.com/v2/get/reviews/${collegeId}"));
      var attData = await http.get(Uri.parse("${ApiBasePort.apiBaseUrl}/v2/get/reviews/${collegeId}"));

      var jsonData = await jsonDecode(attData.body);
      print("review data = ${jsonData}");

      if(jsonData.containsKey("responseDataArray")) {
        dynamic responseDataArray = jsonData["responseDataArray"];
        print("get review Data = ${jsonData}");
        print("get review Data length= ${responseDataArray.length}");

        // check review data in impty or not?
        if (responseDataArray is List<dynamic>) {
          // first List is not Empty or not.
          if(responseDataArray.isNotEmpty){
            List<dynamic> reviewData = responseDataArray;
            print("get review Data = ${jsonData}");
            print("get review Data length= ${reviewData.length}");
            return reviewData;
          } else {
            print("No reviews available for this college.");
          // Show toast message indicating that the data is empty
          // Fluttertoast.showToast(
          //   msg: "No reviews available for this college.",
          //   toastLength: Toast.LENGTH_LONG,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
          // Return an empty list to indicate no data
          return [];
        }
        }else if(responseDataArray is String  && responseDataArray.toLowerCase() == "error"){
          // Show toast message indicating an error
          Fluttertoast.showToast(
            msg: "An error occurred while fetching reviews. Please try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor:kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // Return an empty list to indicate no data
          return [];
        }
        }
      throw Exception('Invalid format in API response');
      } catch (e) {
      print("====$e");
      // Show toast message for any exception
      Fluttertoast.showToast(
        msg: "Failed to fetch reviews. Please try again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      rethrow;
    }
  }

  static postApi(String collegeId, String studentId,String text,String stars) async {
    try {
      print("review  collegeId = $collegeId");
      print("review studentId = $studentId");
      print("review text = $text");
      print("review star = $stars");


      var body = jsonEncode(<String, dynamic>{
        "collegeid": collegeId,
        "studentid": studentId,
        "text"     : text,
        "reviewStar" : stars,
      });

      print("Request body: $body");
      // var response = await http.post(Uri.parse("https://backend.scolage.com/v2/reviews"),
          var response = await http.post(Uri.parse("${ApiBasePort.apiBaseUrl}/v2/reviews"),
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      print("Response status code: ${response.statusCode}");
      print("favorite College  response === ${response.body}");

      var json = jsonEncode(response.body);
      print("auth data is here");
      print(json);

      // print("==================$jsonData");
      print("--------------------------->>>>>${response.statusCode}");

      Map<String, dynamic> map = jsonDecode(response.body);
      if (map["message"] == "Review created successfully") {
        Fluttertoast.showToast(
            msg: "Your Review is Successful submit",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor:kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0
        );
       Get.back();
      } else {
        Fluttertoast.showToast(
          msg: "Review is not submitted",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor:kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      return json;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static Future<List<dynamic>> getStudentReview(String studentId) async {
    try {
      print("in get api");
      // var attData = await http.get(Uri.parse("https://backend.scolage.com/v2/get/reviews/student/${studentId}"));
      var attData = await http.get(Uri.parse("${ApiBasePort.apiBaseUrl}/v2/get/reviews/student/${studentId}"));
      var jsonData = await jsonDecode(attData.body);
      print("Student review data = ${jsonData}");

      if(jsonData.containsKey("responseDataArray")) {
        List<dynamic> reviewData =  jsonData["responseDataArray"];
        print("get Student review Data = ${reviewData}");
        print("get Student review Data length= ${reviewData.length}");


        return reviewData;

      }else {
        throw Exception('Data key not found in API response');
      }

    } catch (e) {
      print("====$e");
      rethrow;
    }
  }
}