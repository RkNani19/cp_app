import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/project_model.dart';
import 'package:gjk_cp/view/call_us.dart';
import 'package:gjk_cp/view/cp_details.dart';
import 'package:gjk_cp/view/cp_login_screen.dart';
import 'package:gjk_cp/view/enquiry.dart';
import 'package:gjk_cp/view/home_screen.dart';
import 'package:gjk_cp/view/login_screen.dart';
import 'package:gjk_cp/view/tele_caller.dart';
import 'package:gjk_cp/view/video_screen.dart';
import 'package:gjk_cp/viewmodel/EnquiryViewModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// 🔷 COLORS
class AppColors {
  static const Color background = Color(0xFFF7F9FC);
  static const Color primaryDark = Color(0xFF00155B);
  static const Color accentGold = Color(0xFFC49A50);
  static const Color textGrey = Color(0xFF6C757D);
  static const Color white = Colors.white;
}

/// 🔷 DRAWER COLORS
class DrawerColors {
  static const Color bg = Color(0xFF0A1F66);
  static const Color divider = Color(0xFF1E3A8A);
  static const Color avatarGold = Color(0xFFC9A24A);
}

/// 🔷 DASHBOARD
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.title});
  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String userName = "";
  String mobile = "";
  List<ProjectModel> _projects = [];
  bool _projectsLoading = false;

  /// 🔥 LOAD USER DATA
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString("userName") ?? "Guest User";
      mobile = prefs.getString("mobile") ?? "No Mobile";
    });
  }

  int _selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 🔥 PAGES LIST
  final List<Widget> _pages = [
    HomeScreen(title: "Home"),
    CpLoginScreen(title: "CP Login"),
    Enquiry(title: 'Enquiry'),
    CallUs(title: "Call Us"),
    VideoScreen(title: "Video"),
    CpDetails(title: "CP Details"),
    TeleCaller(title: "Tele Caller"),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      /// 👉 ENQUIRY CLICK → OPEN BOTTOM SHEET
      showEnquiryBottomSheet(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
    fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,

      /// ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,

        /// MENU ICON
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // ✅ FIXED
          },
        ),

        /// TITLE
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'GJKedia',
              style: TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
            Text(
              'HOMES',
              style: TextStyle(
                color: AppColors.accentGold,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        /// NOTIFICATION
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined),
                onPressed: () {},
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.accentGold,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      /// ================= DRAWER =================
      drawer: Drawer(
        backgroundColor: DrawerColors.bg,
        child: SafeArea(
          child: Column(
            children: [
              /// CLOSE BUTTON
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              /// PROFILE
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: DrawerColors.avatarGold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          mobile,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Divider(color: DrawerColors.divider),

              /// MENU ITEMS
              drawerItem(Icons.home_outlined, "Home", () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 0);
              }),

              drawerItem(Icons.person_outline, "CP Details", () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 5);
              }),

              drawerItem(Icons.call_outlined, "Tele Caller", () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 6);
              }),

              drawerItem(Icons.login, "Customer Login", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen(title: "")),
                );
              }),

              const Spacer(),

              /// LOGOUT
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.1),
                  ),
                  onPressed: () => showLogoutDialog(context),
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /// ================= BODY =================
      body: _pages[_selectedIndex],

      /// ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex.clamp(0, 4), // ✅ FIXED
        onTap: _onItemTapped,
        selectedItemColor: AppColors.accentGold,
        unselectedItemColor: AppColors.textGrey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "CP Login"),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: "Enquiry",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: "Call Us"),
          BottomNavigationBarItem(icon: Icon(Icons.video_call), label: "Video"),
        ],
      ),
    );
  }

  /// 🔷 DRAWER ITEM
  Widget drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  /// 🔷 LOGOUT DIALOG
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove("isLoggedIn");

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(title: "Login"),
                ),
                (route) => false,
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
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
}
