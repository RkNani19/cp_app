import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/project_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? cpId; // ✅ Dynamic CP ID

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
    getCpId();
  }

Future<void> getCpId() async {
  final prefs = await SharedPreferences.getInstance();

  int? storedCpId = prefs.getInt('cpId'); // ✅ correct key + type

  setState(() {
    cpId = storedCpId?.toString(); // convert int → string
  });

  print("CP ID: $cpId"); // debug
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

  /// ✅ SUBMIT API
  Future<void> submitSiteVisit() async {
    if (cpId == null || cpId!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please login again")));
      return;
    }

    if (selectedProject == null ||
        nameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    try {
      setState(() => _isLoading = true);

      /// 🔷 FORMAT DATE
      String formattedDate =
          "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";

      /// 🔷 FORMAT TIME
      String time = selectedTime!.split(" - ")[0];

      int hour = int.parse(time.split(":")[0]);
      int minute = int.parse(time.split(":")[1].split(" ")[0]);

      if (time.contains("PM") && hour != 12) {
        hour += 12;
      } else if (time.contains("AM") && hour == 12) {
        hour = 0;
      }

      String formattedTime =
          "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00";

      /// 🔷 API URL
      final url =
          "${AppConfig.baseUrl}/customerapp/createcpleadsitevisite"
          "?fullname=${nameController.text}"
          "&mobile_number=${mobileController.text}"
          "&email=${emailController.text}"
          "&notes=${requirementsController.text}"
          "&cp_id=$cpId"
          "&project_id=${selectedProject!.projectId}"
          "&country_code=91"
          "&activity_date=$formattedDate"
          "&activity_time=$formattedTime";

      print("site visit booking Url: $url");

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data[0]['msg'] == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data[0]['error_text'] ?? "Failed")),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Booking Successful")));

          /// ✅ CLEAR FORM
          clearForm();
        }
      } else {
        throw Exception("API Failed");
      }
    } catch (e) {
      debugPrint("API Error: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// ✅ CLEAR FORM
  void clearForm() {
    nameController.clear();
    mobileController.clear();
    emailController.clear();
    requirementsController.clear();

    setState(() {
      selectedProject = null;
      selectedTime = null;
      selectedDate = null;
    });
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
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                              items: _projects
                                  .map(
                                    (p) => DropdownMenuItem(
                                      value: p,
                                      child: Text(p.projectName),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) =>
                                  setState(() => selectedProject = val),
                            ),
                          ),
                        ),

                        label("Your Name"),
                        inputField("Enter full name", nameController),

                        label("Mobile Number"),
                        inputField(
                          "+91 00000 00000",
                          mobileController,
                          keyboard: TextInputType.phone,
                        ),

                        label("Email (Optional)"),
                        inputField(
                          "your@example.com",
                          emailController,
                          keyboard: TextInputType.emailAddress,
                        ),

                        label("Preferred Date"),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            decoration: boxDecoration(),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  selectedDate == null
                                      ? "dd-MM-yyyy"
                                      : formatDate(selectedDate!),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.calendar_month,
                                  size: 18,
                                  color: Colors.black,
                                ),
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
                              items: timeSlots
                                  .map(
                                    (t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(t),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) =>
                                  setState(() => selectedTime = val),
                            ),
                          ),
                        ),

                        label("Special Requirements (Optional)"),
                        inputField(
                          "Any specific requirements...",
                          requirementsController,
                          maxLines: 4,
                        ),

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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed:submitSiteVisit,
                      child: const Text(
                        "Confirm Booking",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  Widget inputField(
    String hint,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
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
