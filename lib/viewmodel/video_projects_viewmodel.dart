import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/model/video_project_model.dart';
import 'package:http/http.dart' as http;

import '../model/project_model.dart';

class VideoProjectsViewmodel extends ChangeNotifier {
  List<VideoProjectModel> projects = [];
  bool isLoading = false;
  String error = '';

  String selectedCategory = "All";

  Future<void> fetchProjects() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("https://gjk.tranquilcrmone.in/mobileapp/projectsformobileapp"),
      );

      print("PROJECT API: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        projects = [
          VideoProjectModel(id: "0", name: "All"),
          ...data.map<VideoProjectModel>((e) => ProjectModel.fromJson(e)).toList(),
        ];
      } else {
        error = "Server error";
      }
    } catch (e) {
      error = "Something went wrong";
    }

    isLoading = false;
    notifyListeners();
  }

  void selectCategory(String name) {
    selectedCategory = name;
    notifyListeners();
  }
}