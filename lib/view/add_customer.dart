import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:http/http.dart' as http;

class ProjectModel {
  final String projectId;
  final String projectName;

  ProjectModel({required this.projectId, required this.projectName});

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectId: json['project_id']?.toString() ?? '',
      projectName: json['project_name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"project_id": projectId, "project_name": projectName};
  }
}

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key, required this.title});
  final String title;

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  // --- State variables for the project dropdown ---
  List<ProjectModel> _projectList = [];
  ProjectModel? _selectedProject;
  bool _isLoadingProjects = true;

  @override
  void initState() {
    super.initState();
    // Fetch projects when the widget is first created.
    _fetchProjects();
  }

  // --- API call to fetch the list of projects ---
  Future<void> _fetchProjects() async {
    try {
      final response = await http.get(
        Uri.parse("${AppConfig.baseUrl}/mobileapp/projectsformobileapp"),
      );

      // 🔥 ONLY THIS PRINT
      print(response.body);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        setState(() {
          _projectList = data.map((e) => ProjectModel.fromJson(e)).toList();
          _isLoadingProjects = false;
        });
      } else {
        setState(() => _isLoadingProjects = false);
      }
    } catch (e) {
      print(e); // only error print
      setState(() => _isLoadingProjects = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color pageBackgroundColor = Color(0xFFF8F9FA);
    const Color buttonColor = Color(0xFF0D256E);

    return Scaffold(
      backgroundColor: pageBackgroundColor,
      appBar: AppBar(
        backgroundColor: pageBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Add New Customer",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Select Project Section ---
              _buildLabel('Select Project'),
              const SizedBox(height: 8),
              _buildProjectDropdown(), // This now uses the fetched data
              const SizedBox(height: 24),

              // --- Customer Name Section ---
              _buildLabel('Customer Name'),
              const SizedBox(height: 8),
              _buildTextField(hintText: 'Enter full name'),
              const SizedBox(height: 24),

              // --- Mobile Number Section ---
              _buildLabel('Mobile Number'),
              const SizedBox(height: 8),
              _buildTextField(
                hintText: '+91 00000 00000',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),

              // --- Email Section ---
              _buildLabel('Email (Optional)'),
              const SizedBox(height: 8),
              _buildTextField(
                hintText: 'customer@example.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              // --- Notes Section ---
              _buildLabel('Notes'),
              const SizedBox(height: 8),
              _buildNotesField(),
              const SizedBox(height: 32),

              // --- Submit Button ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle submit action
                    // You can now access the selected project ID: _selectedProject?.projectId
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Submit Lead',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: _inputDecoration(hintText),
    );
  }

  Widget _buildNotesField() {
    return TextFormField(
      minLines: 4,
      maxLines: 6,
      decoration: _inputDecoration(
        'Add any additional notes...',
      ).copyWith(suffixIcon: Icon(Icons.mic_none, color: Colors.grey[600])),
    );
  }

  // --- UPDATED: Dynamic Dropdown for Projects ---
  Widget _buildProjectDropdown() {
    return DropdownButtonFormField<ProjectModel>(
      value: _selectedProject,

      onTap: () async {
        // ✅ CALL API WHEN CLICKED
        if (_projectList.isEmpty) {
          print("🔥 Dropdown clicked → calling API");

          setState(() {
            _isLoadingProjects = true;
          });

          await _fetchProjects(); // ✅ FIXED
        }
      },

      hint: _isLoadingProjects
          ? const Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 10),
                Text('Loading projects...'),
              ],
            )
          : Text('Select a project', style: TextStyle(color: Colors.grey[500])),

      onChanged: (ProjectModel? newValue) {
        setState(() {
          _selectedProject = newValue;
        });
      },

      items: _projectList.map((project) {
        return DropdownMenuItem<ProjectModel>(
          value: project,
          child: Text(project.projectName),
        );
      }).toList(),

      decoration: _inputDecoration(''),
      icon: const Icon(Icons.keyboard_arrow_down),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[500]),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.5,
        ),
      ),
    );
  }
}