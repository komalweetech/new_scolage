import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/apiData/api_base_port.dart';

class StudentLoginApi {
  static postApi(String mobile, String password) async {
    try {
      print("in get api === $mobile");
      print("in get api === $password");
      var body =
          jsonEncode(<String, String>{"mobile": mobile, "password": password});
      print(body);
      // var attData = await http.post(Uri.parse("https://backend.scolage.com/v2/login/student"), body: body, headers: {'Content-Type': 'application/json'});
      var attData = await http.post(
          Uri.parse("${ApiBasePort.apiBaseUrl}/v2/login/student"),
          body: body,
          headers: {'Content-Type': 'application/json'});
      print("attdata == $attData");
      // https://test1.scolage.com/v2/login/student
      var json = jsonDecode(attData.body);
      print("auth data is here");
      print(json);

      // print("==================$jsonData");
      print("--------------------------->>>>>${attData.statusCode}");

      return json;
    } catch (e) {
      print("====$e");
      return ["error"];
    }
  }
}
