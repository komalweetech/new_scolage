import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../utils/apiData/api_base_port.dart';


class OtpApi {
  static postApi(String mobile) async  {
    try {
      print("user Mobile number is  === $mobile");

      var body = jsonEncode(<String, String>{
        "mobile": mobile,
        "purpose": "signUp",
      });

      print("Request body: $body");
      // var response = await http.post(Uri.parse("https://backend.scolage.com/v2/Auth/Otp/Reg"),
          var response = await http.post(Uri.parse("${ApiBasePort.apiBaseUrl}/v2/Auth/Otp/Reg"),

        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      print("Response status code: ${response.statusCode}");
      print("otp json response === ${response.body}");

      var json = jsonEncode(response.body);
      print("auth data is here");
      print(json);

      // print("==================$jsonData");
      print("--------------------------->>>>>${response.statusCode}");

      return json;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
class VerifyOtp {
  static Future<Map<String, dynamic>?> postApi(String mobile, String otp) async {
    try {
      print("Verify Mobile number is  === $mobile");

      var body = jsonEncode(<String, String>{
        "mobile": mobile,
        "otp": otp,
      });

      print("Verify Request body: $body");

      // Call the API
      var response = await http.post(
        Uri.parse("${ApiBasePort.apiBaseUrl}/v2/verifyOtp"),
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      print("Verify status code: ${response.statusCode}");
      print("OTP JSON Verify response === ${response.body}");

      // Decode the JSON response
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // Add the status code to the response map
      jsonResponse['statusCode'] = response.statusCode;

      return jsonResponse;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}

// class VerifyOtp {
//   static postApi(String mobile,String otp) async  {
//     try {
//       print("Verify Mobile number is  === $mobile");
//
//       var body = jsonEncode(<String, String>{
//         "mobile": mobile,
//         "otp": otp,
//       });
//
//       print(" Verify Request body: $body");
//
//       log("api is not calling");
//       // var response = await http.post(Uri.parse("https://backend.scolage.com/v2/verifyOtp"),
//       var response = await http.post(Uri.parse("${ApiBasePort.apiBaseUrl}/v2/verifyOtp"),
//
//         body: body,
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       log("api is fail.");
//       print("Verify  status code: ${response.statusCode}");
//       print("otp json Verify response === ${response.body}");
//
//
//       var json = jsonEncode(response.body);
//       print(json);
//
//       // print("==================$jsonData");
//       print("--------------------------->>>>>${response.statusCode}");
//
//       return json;
//     } catch (e) {
//       print("Error: $e");
//       return null;
//     }
//   }
// }
