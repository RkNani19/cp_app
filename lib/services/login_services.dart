import 'dart:convert';
import 'package:gjk_cp/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:gjk_cp/config/app_config.dart'; // ✅ import this

class LoginService {
  Future<LoginModel?> login(String email, String password) async {
    try {
     
      final uri = Uri.parse("${AppConfig.baseUrl}/mobileapp/cplogin").replace(
        queryParameters: {
          "email": email,
          "password": password,
        },
      );

      print("API URL: $uri");

      final response = await http.get(uri);

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is List && decoded.isNotEmpty) {
          return LoginModel.fromJson(decoded[0]);
        } else {
          print("EMPTY RESPONSE");
        }
      }
    } catch (e) {
      print("ERROR: $e");
    }

    return null;
  }
}