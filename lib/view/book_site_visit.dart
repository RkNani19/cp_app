import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/project_model.dart';

class BookSiteVisitScreen extends StatefulWidget {
  final String title;
  const BookSiteVisitScreen({super.key, required this.title});

  @override
  State<BookSiteVisitScreen> createState() => _BookSiteVisitScreenState();
}

class _BookSiteVisitScreenState extends State<BookSiteVisitScreen> {
  // Data for Dropdowns
  List<ProjectModel> _projects = [];
  bool _isLoading = true;
  ProjectModel? selectedProject;
  String? selectedTime;

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  DateTime? selectedDate;

  final List<String> timeSlots = [
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM",
    "12:00 PM - 01:00 PM",
    "02:00 PM - 03:00 PM",
    "04:00 PM - 05:00 PM",
  ];

  @override
  void initState() {
    super.initState();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    try {
      final response = await http.get(
        Uri.parse("${AppConfig.baseUrl}/mobileapp/projectsformobileapp"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _projects = data.map((e) => ProjectModel.fromJson(e)).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error: $e');
      setState(() => _isLoading = false);
    }
  }

  // Date Picker Function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        label("Select Project"),
                        dropdownContainer(
                          DropdownButtonHideUnderline(
                            child: DropdownButton<ProjectModel>(
                              isExpanded: true,
                              value: selectedProject,
                              hint: const Text("Select project"),
                              items: _projects.map((p) => DropdownMenuItem(value: p, child: Text(p.projectName))).toList(),
                              onChanged: (val) => setState(() => selectedProject = val),
                            ),
                          ),
                        ),
                        
                        label("Your Name"),
                        inputField("Enter full name", nameController),
                        
                        label("Mobile Number"),
                        inputField("+91 00000 00000", mobileController, keyboard: TextInputType.phone),
                        
                        label("Email (Optional)"),
                        inputField("your@example.com", emailController, keyboard: TextInputType.emailAddress),
                        
                        label("Preferred Date"),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            decoration: boxDecoration(),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.grey),
                                const SizedBox(width: 10),
                               Text(
  selectedDate == null
      ? "dd-MM-yyyy"
      : formatDate(selectedDate!),
),
                                const Spacer(),
                                const Icon(Icons.calendar_month, size: 18, color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                        
                        label("Preferred Time"),
                        dropdownContainer(
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedTime,
                              hint: const Text("Select time slot"),
                              items: timeSlots.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                              onChanged: (val) => setState(() => selectedTime = val),
                            ),
                          ),
                        ),
                        
                        label("Special Requirements (Optional)"),
                        inputField("Any specific requirements...", requirementsController, maxLines: 4),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                
                /// 🔷 BOTTOM BUTTON
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00155B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        // Implement submission logic
                      },
                      child: const Text("Confirm Booking", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  /// 🔷 UI HELPERS
  Widget label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }

  Widget inputField(String hint, TextEditingController controller, {TextInputType keyboard = TextInputType.text, int maxLines = 1}) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
      ),
    );
  }

  Widget dropdownContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: boxDecoration(),
      child: child,
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE0E0E0)),
    );
  }
  
  String formatDate(DateTime date) {
  String day = date.day.toString().padLeft(2, '0');
  String month = date.month.toString().padLeft(2, '0');
  String year = date.year.toString();

  return "$day-$month-$year";
}
}