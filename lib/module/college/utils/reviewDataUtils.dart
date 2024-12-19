


import '../services/review_api.dart';

class ReviewDataUtils {
  static List<dynamic> reviewDataList = [];

  static Future<void> fetchData(String collegeID) async {
    try {
      var jsonData = await ReviewsApi.getReviewsApi(collegeID);
      reviewDataList = jsonData;
      print("review data utils  == $reviewDataList");
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

}

class DrawerReviewDataUtils {
  static List<dynamic> reviewDataList = [];

  static Future<void> fetchData(String studentId) async {
    try {
      var jsonData = await ReviewsApi.getStudentReview(studentId);
      reviewDataList = jsonData;
      print("review data utils  == $reviewDataList");
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

}