import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/all_project_model.dart';
import 'package:gjk_cp/view/view_all_projects.dart';
import 'package:http/http.dart' as http;

class ViewAllProjects extends StatefulWidget {
  const ViewAllProjects({super.key});

  @override
  State<ViewAllProjects> createState() => _ViewAllProjectsState();
}

class _ViewAllProjectsState extends State<ViewAllProjects> {
  List<AllProjectModel> projectList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    final url =
        "${AppConfig.baseUrl}/customerapp/menunextp?project_id=1&start=0";

    print("API URL: $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);

      projectList =
          data.map((e) => AllProjectModel.fromJson(e)).toList();

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Projects")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: projectList.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return ProjectCard(data: projectList[index]);
              },
            ),
    );
  }
}