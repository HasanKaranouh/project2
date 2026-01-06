import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://hasankaranouh.atwebpages.com/api";

  // REGISTER
  static Future<bool> register(String name, String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/register.php"),
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
      headers: {"Content-Type": "application/json"},
    );
    final data = json.decode(res.body);
    return data['success'] == true;
  }

  // LOGIN
  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login.php"),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (data["success"] == true) {
      return data["name"];
    } else {
      return null;
    }
  }

  // MARK ATTENDANCE
  static Future<bool> markAttendance(
      String userName, String subject, String status) async {
    final res = await http.post(
      Uri.parse("$baseUrl/mark_attendance.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_name": userName,
        "subject": subject,
        "status": status,
      }),
    );
    final data = json.decode(res.body);
    return data['success'] == true;
  }

  // GET ATTENDANCE RECORDS
  static Future<List<dynamic>> getAttendance() async {
    final res = await http.get(Uri.parse("$baseUrl/get_attendance.php"));
    final data = jsonDecode(res.body);
    return data['records'];
  }
}
