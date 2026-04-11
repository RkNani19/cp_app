import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/cp_dashboard_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CpDashboardViewModel extends ChangeNotifier {
  CpDashboardModel? dashboard;
  bool isLoading = false;

  Future<void> fetchDashboard() async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final cpId = prefs.getInt("cpId") ?? 0;

      final url =
      "${AppConfig.baseUrl}/mobileapp/cpleadsadatawithcommsion?cp_id=$cpId";
         

      print("CP DASHBOARD API: $url");

      final response = await http.get(Uri.parse(url));

      print("RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is Map<String, dynamic>) {
          dashboard = CpDashboardModel.fromJson(data);
        }
      }
    } catch (e) {
      print("ERROR: $e");
      dashboard = null;
    }

    isLoading = false;
    notifyListeners();
  }
}