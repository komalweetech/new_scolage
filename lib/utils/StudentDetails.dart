class StudentDetails {
  // DT TO DD-MM-YYYY
  static String name = "";
  static String studentId = "";
  static String mobile = "";
  static String email = "";
  static String schoolName = "";
  static String role = "";

  static void updateFromMap(Map<String, dynamic> data) {
    name = data['name'] ?? '';
    studentId = data['student_id'] ?? '';
    mobile = data['mobile'] ?? '';
    email = data['email'] ?? '';
    schoolName = data['school_name'] ?? '';
    role = data['role'] ?? '';
  }

}
class StudentSingUp {
  static String role = "";
  static String name = "";
  static String gender = "";
  static String schoolName = "";
  static String studentId = "";
  static String password = "";
  static String confirmPassword = "";
  static String mobile = "";
  static String email = "";
}
