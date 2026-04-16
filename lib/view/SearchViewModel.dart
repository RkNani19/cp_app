import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/model/SearchProjectModel%20.dart';
import 'package:http/http.dart' as http;

class SearchViewModel extends ChangeNotifier {
  List<SearchProjectModel> results = [];
  bool isLoading = false;
  String query = "";

  Future<void> searchProjects(String value) async {
    query = value;
    if (query.isEmpty) {
      results = [];
      isLoading = false;
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final url = "https://gjk.tranquilcrmone.in/customerapp/getprojectsearch?search=$query&start=0";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        results = data.map((e) => SearchProjectModel.fromJson(e)).toList();
      } else {
        results = [];
      }
    } catch (e) {
      debugPrint("Search Error: $e");
      results = [];
    }

    isLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    query = "";
    results = [];
    notifyListeners();
  }
}