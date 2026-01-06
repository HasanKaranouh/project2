import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project2/models/attendance_item.dart';

class ApiService {
  static const String baseUrl = "http://hasankaranouh.atwebpages.com/api/";

  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}register.php"),
        body: {'name': name, 'email': email, 'password': password},
      );
      return json.decode(response.body);
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}login.php"),
        body: {'email': email, 'password': password},
      );
      return json.decode(response.body);
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> markAttendance(String userName, String subject, String status) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}mark_attendance.php"),
        body: {'user_name': userName, 'subject': subject, 'status': status},
      );
      return json.decode(response.body);
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }

  static Future<List<AttendanceItem>> getAttendance(String userName) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}get_attendance.php"),
        body: {'user_name': userName},
      );

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => AttendanceItem.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}