import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/tele_source_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TeleSourceViewModel extends ChangeNotifier {
  List<TeleSourceModel> sourceList = [];
  bool isLoading = true;

  Future<void> fetchSourceTypes() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final cpId = prefs.getInt("cpId") ?? 0;

    final url =
        "${AppConfig.baseUrl}/mobileapp/sourcetypescptele?assigned_to=$cpId";

    print("SOURCE API: $url");

    try {
      final response = await http.get(Uri.parse(url));

      print("RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // ✅ SAFE LIST HANDLING
        if (data is List) {
          sourceList = data
              .map((e) => TeleSourceModel.fromJson(e))
              .toList();
        } else {
          sourceList = [];
        }

        // ✅ Add "All"
        sourceList.insert(
          0,
          TeleSourceModel(id: "0", name: "All", count: "0"),
        );
      } else {
        sourceList = [];
      }
    } catch (e) {
      print("ERROR: $e");
      sourceList = [];
    }

    isLoading = false;
    notifyListeners();
  }
}