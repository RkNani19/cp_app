import 'package:flutter/material.dart';
import 'package:gjk_cp/view/add_customer.dart';
import 'package:gjk_cp/view/creatives.dart';
import 'package:gjk_cp/view/dashboard_screen.dart';
import 'package:gjk_cp/view/sale_history.dart';
import 'package:gjk_cp/view/share.dart';
import 'package:gjk_cp/viewmodel/cp_dashboard_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CpLoginScreen extends StatefulWidget {
  const CpLoginScreen({super.key, required this.title});

  final String title;

  @override
  State<CpLoginScreen> createState() => _CpLoginScreenState();
}

class _CpLoginScreenState extends State<CpLoginScreen> {
  // 🔥 USER DATA
  String cpName = "";
  String cpMobile = "";
  String cpId = "";

  @override
  void initState() {
    super.initState();
    loadCpData();

    Future.microtask(() {
      context.read<CpDashboardViewModel>().fetchDashboard();
    });
  }

  // 🔥 LOAD FROM SHARED PREFERENCES
  Future<void> loadCpData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cpName = prefs.getString("userName") ?? "";
      cpMobile = prefs.getString("mobile") ?? "";
      cpId = (prefs.getInt("cpId") ?? 0).toString();
    });

    debugPrint("👤 cpName: $cpName");
    debugPrint("📱 cpMobile: $cpMobile");
    debugPrint("🆔 cpId: $cpId");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen(title: "")),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],

        /// ✅ SCROLL FIX
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔷 PROFILE CARD
                  profileCard(),

                  const SizedBox(height: 24),

                  /// 🔷 TITLE
                  const Text(
                    "Performance Overview",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),
                  Consumer<CpDashboardViewModel>(
                    builder: (context, vm, child) {
                      if (vm.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (vm.dashboard == null) {
                        return const Text("No Data");
                      }

                      final data = vm.dashboard!;

                      return Column(
                        children: [
                          /// 🔷 DASHBOARD CARDS
                          dashboardCard(
                            "Total Sales",
                            data.totalSalesAmount,
                            "${data.unitsSold} units sold",
                          ),
                          const SizedBox(height: 16),

                          dashboardCard(
                            "Commission Earned",
                            // "₹2.26 Lakhs",
                            data.monthCommission,
                            "This month",
                          ),
                          const SizedBox(height: 16),

                          dashboardCard(
                            "Active Leads",
                            data.activeLeads,
                            "In pipeline",
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  /// 🔷 QUICK ACTIONS
                  const Text(
                    "Quick Actions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1,
                    children: [
                      quickActionItem(
                        Icons.person_add_alt_1,
                        "Add Customer",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AddCustomer(title: ''),
                            ),
                          );
                        },
                      ),

                      quickActionItem(
                        Icons.history,
                        "Sales History",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SalesHistory(),
                            ),
                          );
                        },
                      ),
                      quickActionItem(Icons.image_outlined, "Creatives",
                      onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreativesScreen(),
                            ),
                          );
                        },
                        ),
                      quickActionItem(Icons.share_outlined, "Share App",
                      onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShareScreen(title: '',),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔷 PROFILE CARD
  Widget profileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B6F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          /// Avatar
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.amber[700],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                cpName.isNotEmpty ? cpName[0].toUpperCase() : "CP",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          /// 🔥 DYNAMIC DETAILS FROM SHARED PREFERENCES
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cpName.isNotEmpty ? cpName : "Guest User",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                cpMobile.isNotEmpty ? cpMobile : "No Mobile",
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 4),
              Text(
                "ID: CP$cpId",
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔷 REUSABLE DASHBOARD CARD
  Widget dashboardCard(String title, String value, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B6F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// TEXT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(color: Colors.white70)),
            ],
          ),

          /// ARROW
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔷 QUICK ACTION ITEM
  Widget quickActionItem(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ICON
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF0D1B6F), size: 26),
            ),

            const SizedBox(height: 12),

            /// TEXT
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
