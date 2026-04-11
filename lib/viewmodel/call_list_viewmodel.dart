import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/call_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallListViewmodel extends ChangeNotifier {
  List<CallListModel> callList = [];
  bool isLoading = true;

  Future<void> fetchCalls({required int sourceId}) async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final cpId = prefs.getInt("cpId") ?? 0;

    final url =
        "${AppConfig.baseUrl}/mobileapp/tellecallercpdata?assigned_to=$cpId&page=1&src=$sourceId";

    print("CALL LIST API: $url");

    try {
      final response = await http.get(Uri.parse(url));

      print("RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // ✅ SAFE PARSING (your API has "data" key)
        if (data is Map && data["data"] is List) {
          callList = (data["data"] as List)
              .map((e) => CallListModel.fromJson(e))
              .toList();
        } else {
          callList = [];
        }
      } else {
        callList = [];
      }
    } catch (e) {
      print("ERROR: $e");
      callList = [];
    }

    isLoading = false;
    notifyListeners();
  }
}