import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../utils/apiData/api_base_port.dart';


class CollageArea {

  Future<List<String>> fetchCollegeAreas() async {
    final url = Uri.parse('${ApiBasePort.apiBaseUrl}/v2/getCollegeAreas');
    print("get clg area list url == $url");

    try {
      final response = await http.get(url);

      print("clg area list == ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          final List<dynamic> areas = jsonResponse['collegeAreas'];
          return areas.map((e) => e.toString().trim()).toList();
        } else {
          throw Exception('API returned status: false');
        }
      } else {
        throw Exception('Failed to load college areas');
      }
    } on SocketException catch (e) {
      print('SocketException: $e');
      return [];
    } catch (e) {
      print('Error fetching college areas: $e');
      return [];
    }
  }


}