import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/all_project_model.dart';
import 'package:gjk_cp/view/project_details.dart';
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

      projectList = data.map((e) => AllProjectModel.fromJson(e)).toList();

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Projects")),
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

class ProjectCard extends StatelessWidget {
  final AllProjectModel data;

  const ProjectCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔷 IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              data.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          /// 🔷 CONTENT
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                /// LOCATION
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      data.location.isEmpty
                          ? "Location not available"
                          : data.location,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// PRICE + BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// PRICE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Starting from",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          data.price.isEmpty ? "N/A" : "₹${data.price}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0A2A6A),
                          ),
                        ),
                      ],
                    ),

                    /// BUTTON
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A2A6A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProjectDetailsScreen(projectId: data.id),
                          ),
                        );
                      },
                      child: const Text("View"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
