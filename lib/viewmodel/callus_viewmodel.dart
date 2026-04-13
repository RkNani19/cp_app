import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/model/callus_model.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart'; // 👈 ADD THIS

class CallusViewmodel extends ChangeNotifier {
  CallusModel? office;
  bool isLoading = false;
  String error = '';

  Future<void> fetchOfficeDetails() async {
    isLoading = true;
    error = ''; // 🔥 reset error
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("${AppConfig.baseUrl}/customerapp/getofficedetails"),
      );

      print("API URL: $Uri.parse");
      print("API RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data.isNotEmpty) {
          office = CallusModel.fromJson(data[0]);
        } else {
          error = "No data found";
        }
      } else {
        error = "Server error: ${response.statusCode}";
      }
    } catch (e) {
      error = "Something went wrong";
      debugPrint("API ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}