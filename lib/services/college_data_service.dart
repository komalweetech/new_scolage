import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/apiData/api_base_port.dart';

class CollegeDataService {
  static final CollegeDataService _instance = CollegeDataService._internal();
  factory CollegeDataService() => _instance;
  CollegeDataService._internal();

  Map<String, dynamic>? _cachedData;
  DateTime? _lastFetchTime;
  static const cacheDuration = Duration(minutes: 5);

  Future<Map<String, dynamic>> getAllColleges() async {
    if (_shouldUseCachedData()) {
      return _cachedData!;
    }

    try {
      final response = await http.get(Uri.parse("${ApiBasePort.apiBaseUrl}/v2/collegelist/get"));
      final jsonData = await jsonDecode(response.body);
      
      _cachedData = jsonData;
      _lastFetchTime = DateTime.now();
      
      return jsonData;
    } catch (e) {
      print("Error fetching college data: $e");
      throw Exception("Failed to fetch college data");
    }
  }

  bool _shouldUseCachedData() {
    if (_cachedData == null || _lastFetchTime == null) return false;
    return DateTime.now().difference(_lastFetchTime!) < cacheDuration;
  }

  // Helper methods to get specific data
  Future<List<dynamic>> getCollegeList() async {
    final data = await getAllColleges();
    return data["college"] as List<dynamic>;
  }

  Future<List<dynamic>> getCollegeImages() async {
    final data = await getAllColleges();
    return data["clgimage"] as List<dynamic>;
  }

  Future<List<dynamic>> getSubjects() async {
    final data = await getAllColleges();
    return data["subject"] as List<dynamic>;
  }

  Future<Map<String, dynamic>?> getCollegeById(String collegeId) async {
    final colleges = await getCollegeList();
    return colleges.firstWhere(
      (clg) => clg["collegeid"].toString() == collegeId,
      orElse: () => null,
    );
  }

  // Helper method to handle null values
  String getValue(dynamic value) {
    return (value == null || value.toString().trim().isEmpty || value == "N/A") 
      ? "NULL" 
      : value.toString();
  }

  // Helper method to find data by college ID
  dynamic findByCollegeId(List<dynamic> list, String collegeId, String key) {
    final item = list.firstWhere(
      (item) => item["collegeid"] == collegeId,
      orElse: () => {},
    );
    return item[key];
  }
} 