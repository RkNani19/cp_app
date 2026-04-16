import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/ProjectDetailsModel.dart';
import 'package:gjk_cp/model/project_model.dart';
import 'package:gjk_cp/view/availability.dart';
import 'package:gjk_cp/view/book_site_visit.dart';
import 'package:gjk_cp/view/video_screen.dart';
import 'package:gjk_cp/viewmodel/EnquiryViewModel.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final String projectId;

  const ProjectDetailsScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  ProjectDetailsModel? data;
  bool isLoading = true;
  bool _projectsLoading = false;
  List<ProjectModel> _projects = [];

  @override
  void initState() {
    super.initState();
    fetchDetails();
    fetchProjects();
  }

  Future<void> fetchDetails() async {
    final url =
        "${AppConfig.baseUrl}/customerapp/menucontentnew?menu_id=${widget.projectId}";
    print("projectdetails==>: $url");
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      final menuData = body[0]['menu'][0];
      data = ProjectDetailsModel.fromJson(menuData);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || data == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// 🔷 HEADER IMAGE
          Stack(
            children: [
              Image.network(
                data!.image,
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),

          /// 🔷 CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data!.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Starting from"),
                  Text(
                    "₹${data!.salePrice}", // Changed from static to dynamic
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A2A6A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      chipItem("2 BHK"),
                      chipItem("3 BHK"),
                      chipItem("Ready to Move"),
                      chipItem("RERA Approved"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      actionItem(Icons.picture_as_pdf, "Brochure", () {
                        showFileOptions(data!.brochureDtl);
                      }),
                      actionItem(Icons.map, "Layout", () {
                        showFileOptions(data!.layoutDtl);
                      }),
                      actionItem(Icons.location_on, "Map", () {
                        openMap(data!.lat, data!.lng);
                      }),
                      actionItem(Icons.videocam, "Videos", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoScreen(
                              title: data!.name, // ✅ pass project name
                            ),
                          ),
                        );
                      }),
                      // Find this line in your code:
                      actionItem(Icons.check_box, "Availability", () {
                        // Add the navigation logic here:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AvailabilityScreen(
                              projectId: widget.projectId,
                              projectName: data!.name,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 20),

                  /// 🔷 ABOUT PROPERTY
                  const Text(
                    "About Property",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data!.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// 🔷 AMENITIES SECTION
                  const Text(
                    "Amenities",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  // 🔥 BALANCED GAP: 12px is standard for "title to content" spacing
                  const SizedBox(height: 12),

                  GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    // Remove default top padding so the 12px SizedBox above is the only gap
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    // 🔥 ROW SPACING: 20px makes the second row of icons look clean
                    mainAxisSpacing: 20,
                    // 🔥 RATIO: 0.8 is the "sweet spot" for icon + text vertically
                    childAspectRatio: 0.8,
                    children: [
                      amenityItem(Icons.fitness_center, "Gym"),
                      amenityItem(Icons.pool, "Pool"),
                      amenityItem(Icons.local_parking, "Parking"),
                      amenityItem(Icons.park, "Garden"),
                      amenityItem(Icons.home, "Clubhouse"),
                      amenityItem(Icons.videocam, "CCTV"),
                    ],
                  ),
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      // Enquire Now Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // ✅ Call your existing function here
                            showEnquiryBottomSheet(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF0A2A6A),
                              width: 1.5,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Enquire Now",
                            style: TextStyle(
                              color: Color(0xFF0A2A6A),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // ✅ Navigate to Book Site Visit Screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookSiteVisitScreen(
                                  title: "Book Site Visit",
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A2A6A),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Book Site Visit",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chipItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget actionItem(IconData icon, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Color(0xFFF1EFE9),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Color(0xFF0A2A6A), size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  static Widget amenityItem(IconData icon, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFF1EFE9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: const Color(0xFF0A2A6A), size: 26),
        ),
        const SizedBox(
          height: 6,
        ), // 🔥 Increased from 4 to 6 for better legibility
        Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 1, // Added safety to prevent text wrap issues
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  void showEnquiryBottomSheet(BuildContext context) {
    ProjectModel? selectedProject;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController mobileController = TextEditingController();
    final EnquiryViewModel enquiryVM = EnquiryViewModel(); // 🔥 local VM

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// DRAG HANDLE
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      /// TITLE ROW
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Quick Enquiry",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      /// SELECT PROJECT
                      const Text("Select Project"),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: _projectsLoading
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text("Loading projects..."),
                                  ],
                                ),
                              )
                            : DropdownButtonHideUnderline(
                                child: DropdownButton<ProjectModel>(
                                  isExpanded: true,
                                  value: selectedProject,
                                  hint: const Text("Select a project"),
                                  items: _projects
                                      .map(
                                        (project) =>
                                            DropdownMenuItem<ProjectModel>(
                                              value: project,
                                              child: Text(project.projectName),
                                            ),
                                      )
                                      .toList(),
                                  onChanged: (ProjectModel? value) {
                                    setSheetState(() {
                                      selectedProject = value;
                                    });
                                  },
                                ),
                              ),
                      ),

                      const SizedBox(height: 16),

                      /// NAME
                      const Text("Your Name"),
                      const SizedBox(height: 6),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Enter your name",
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// MOBILE
                      const Text("Mobile Number"),
                      const SizedBox(height: 6),
                      TextField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "+91 00000 00000",
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// 🔥 SUBMIT BUTTON — ListenableBuilder listens to enquiryVM
                      ListenableBuilder(
                        listenable: enquiryVM,
                        builder: (context, _) {
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D1B6F),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                disabledBackgroundColor: const Color(
                                  0xFF0D1B6F,
                                ).withOpacity(0.6),
                              ),
                              onPressed: enquiryVM.isLoading
                                  ? null
                                  : () async {
                                      if (selectedProject == null) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Please select a project",
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      final success = await enquiryVM
                                          .submitEnquiry(
                                            projectId:
                                                selectedProject!.projectId,
                                            name: nameController.text.trim(),
                                            mobile: mobileController.text
                                                .trim(),
                                          );

                                      if (success) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              enquiryVM.enquiryResponse!.msg,
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              enquiryVM.errorMessage ??
                                                  "Failed",
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                              child: enquiryVM.isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "Submit Enquiry",
                                      style: TextStyle(fontSize: 16),
                                    ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> fetchProjects() async {
    setState(() => _projectsLoading = true);
    try {
      final response = await http.get(
        Uri.parse("${AppConfig.baseUrl}/mobileapp/projectsformobileapp"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _projects = data.map((e) => ProjectModel.fromJson(e)).toList();
        });
      }
    } catch (e) {
      debugPrint('Error fetching projects: $e');
    } finally {
      setState(() => _projectsLoading = false);
    }
  }

  void showFileOptions(String url) {
    if (url.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No data available")));
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 🔷 TITLE
                const Text(
                  "Select Option",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                /// 🔥 BUTTON ROW
                Row(
                  children: [
                    /// 🔷 SHARE BUTTON (LEFT)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          Share.share(url);
                        },
                        icon: const Icon(Icons.share),
                        label: const Text("Share"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// 🔷 VIEW BUTTON (RIGHT)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          Navigator.pop(context);

                          final uri = Uri.parse(url);

                          if (await canLaunchUrl(uri)) {
                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Cannot open file")),
                            );
                          }
                        },
                        icon: const Icon(Icons.remove_red_eye),
                        label: const Text("View"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A2A6A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void openMap(String lat, String lng) async {
    if (lat.isEmpty || lng.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Location not available")));
      return;
    }

    final url = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Could not open map")));
    }
  }
}
