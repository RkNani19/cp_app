import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/model/project_model.dart';
import 'package:http/http.dart' as http;
import 'package:gjk_cp/config/app_config.dart';
import '../model/register_model.dart';
import '../services/register_sevices.dart';

class RegisterViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool isLoading = false;

  // 🔥 ADD THIS PART
  List<ProjectModel> projectList = [];
  ProjectModel? selectedProject;

  Future<void> fetchProjects() async {
    final response = await http.get(
      Uri.parse("${AppConfig.baseUrl}/mobileapp/projectsformobileapp"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      projectList =
          data.map((e) => ProjectModel.fromJson(e)).toList();

      notifyListeners();
    }
  }

  void setSelectedProject(ProjectModel project) {
    selectedProject = project;
    notifyListeners();
  }

  // 🔥 YOUR EXISTING REGISTER API
  Future<RegisterResponse> register({
    required String name,
    required String email,
    required String mobile,
    required String password,
    required String confirmPassword,
    required String city,
    required String endpoint,
  }) async {

    if (name.isEmpty || email.isEmpty || mobile.isEmpty || password.isEmpty) {
      return RegisterResponse(status: "0", msg: "Fill all fields");
    }

    if (password != confirmPassword) {
      return RegisterResponse(status: "0", msg: "Passwords do not match");
    }

    isLoading = true;
    notifyListeners();

    final response = await _apiService.getRequest(
      endpoint: "customerapp/newregister",
      queryParams: {
        "fullname": name,
        "email": email,
        "mobile": mobile,
        "password": password,
        "gcm_id": "852",

        // 🔥 IMPORTANT (dynamic project id)
        "project_d": selectedProject?.projectId ?? "",

        "location": city,
      },
    );

    isLoading = false;
    notifyListeners();

    return response;
  }
}