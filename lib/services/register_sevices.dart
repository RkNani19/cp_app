import 'dart:convert';
import 'package:gjk_cp/config/app_config.dart';
import 'package:http/http.dart' as http;
import '../model/register_model.dart';

class ApiService {
  Future<RegisterResponse> getRequest({
    required String endpoint,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse(
        "${AppConfig.baseUrl}/$endpoint",
      ).replace(queryParameters: queryParams);

      print("Request url: $uri");

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RegisterResponse.fromJson(data);
      } else {
        return RegisterResponse(status: "0", msg: "Server Error");
      }
    } catch (e) {
      return RegisterResponse(status: "0", msg: "Exception: $e");
    }
  }
}



