import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/telle_call_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TellCallViewmodel extends ChangeNotifier {
  TelleCallModel? calldata;

  bool isLoading = true;

  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final cpId = prefs.getInt("cpId") ?? 0;

    final url =
        "${AppConfig.baseUrl}/mobileapp/getcptelecallercounts?assigned_to=$cpId";

    print("call view API: $url");

    try {
      final response = await http.get(Uri.parse(url));

      print("RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List && data.isNotEmpty) {
          calldata = TelleCallModel.fromJson(data[0]); // ✅ FIX
        } else if (data is Map<String, dynamic>) {
          calldata = TelleCallModel.fromJson(data);
        } else {
          calldata = null;
        }
      }
    } catch (e) {
      print("ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
