import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gjk_cp/model/fetch_project_model.dart';
import 'package:http/http.dart' as http;

class FethProjectViewmodel extends ChangeNotifier {
  bool isLoading = false;
  List<FetchProjectModel> projects = [];

  Future<void> fetchProjects() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          "https://gjk.tranquilcrmone.in/customerapp/menunextp?project_id=1&start=0"));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        projects = data.map((e) => FetchProjectModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("API ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}