import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://emasjid.id/api/auth/";

  // API untuk login
  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url = Uri.parse('${baseUrl}login.php');
    final body = {
      'username': username,
      'password': password,
    };

    print("Sending login request to: $url with body: $body");

    try {
      final response = await http.post(url, body: body);
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          print("Response body is empty");
          return null;
        }
      } else {
        return {'status': 'error', 'message': 'Gagal terhubung ke server.'};
      }
    } catch (e) {
      print("Error during API request: $e");
      return {
        'status': 'error',
        'message': 'Terjadi kesalahan saat menghubungi server.'
      };
    }
  }

  Future<Map<String, dynamic>?> register(String username, String name, String phone, String email, String password) async {
    final url = Uri.parse('${baseUrl}register.php');
    final body = {
      'username': username,
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    };

    print("Sending register request to: $url with body: $body");

    try {
      final response = await http.post(url, body: body);
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          print("Response body is empty");
          return null;
        }
      } else {
        print("Failed to connect to server. Status code: ${response.statusCode}");
        return {'status': 'error', 'message': 'Gagal terhubung ke server.'};
      }
    } catch (e) {
      print("Error during API request: $e");
      return {'status': 'error', 'message': 'Terjadi kesalahan saat menghubungi server: $e'};
    }
  }
}
