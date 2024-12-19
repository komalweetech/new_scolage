import 'package:shared_preferences/shared_preferences.dart';

// Save user login credentials
Future<void> saveUserCredentials(String mobile, String email, String studentID, String name) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('mobile', mobile);
  prefs.setString('email', email);
  prefs.setString("studentid", studentID);
  prefs.setString("name", name);
}

// Retrieve user login credentials
Future<Map<String, String>> getUserCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  final mobile = prefs.getString('mobile') ?? '';
  final password = prefs.getString('password') ?? '';
  return {'mobile': mobile, 'password': password};
}

// Remove user login credentials (logout)
Future<void> removeUserCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('mobile');
  await prefs.remove('password');
}
