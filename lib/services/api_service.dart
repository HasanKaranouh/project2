import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://hasankaranouh.atwebpages.com/api";

  // REGISTER
  static Future<bool> register(
      String name, String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/register.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    final data = json.decode(res.body);
    return data['success'] == true;
  }

  // LOGIN
  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (data["success"] == true) {
      return data["name"];
    }
    return null;
  }

  // GET NOTICES
  static Future<List<dynamic>> getNotices() async {
    final res = await http.get(Uri.parse("$baseUrl/get_notices.php"));
    final data = json.decode(res.body);
    return data["notices"];
  }

  // ADD NOTICE
  static Future<bool> addNotice(String userName, String content) async {
    final res = await http.post(
      Uri.parse("$baseUrl/add_notice.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_name": userName,
        "content": content,
      }),
    );

    final data = json.decode(res.body);
    return data['success'] == true;
  }
}
