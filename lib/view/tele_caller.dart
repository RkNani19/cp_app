import 'package:flutter/material.dart';
import 'package:gjk_cp/model/call_list_model.dart';
import 'package:gjk_cp/model/tele_source_model.dart';
import 'package:gjk_cp/view/dashboard_screen.dart';
import 'package:gjk_cp/viewmodel/call_action_viewmodel.dart';
import 'package:gjk_cp/viewmodel/call_list_viewmodel.dart';
import 'package:gjk_cp/viewmodel/tele_source_viewmodel.dart';
import 'package:gjk_cp/viewmodel/tell_call_viewmodel.dart';
import 'package:provider/provider.dart';

class TeleCaller extends StatefulWidget {
  final String title;

  const TeleCaller({super.key, required this.title});

  @override
  State<TeleCaller> createState() => _TeleCallerState();

 
}

class _TeleCallerState extends State<TeleCaller> {
  List<TeleSourceModel> sourceList = [];
  int selectedIndex = 0;
  bool isLoading = true;

  List<CallListModel> callList = [];
  bool isCallLoading = true;
  int selectedSourceId = 0;


  @override
  void initState() {
    super.initState();
    //fetchSourceTypes();
    Future.microtask(() {
      context.read<CallListViewmodel>().fetchCalls(sourceId: 0);
      context.read<TellCallViewmodel>().fetchData();
      context.read<TeleSourceViewModel>().fetchSourceTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    double itemAspectRatio = 1.05;

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
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: SingleChildScrollView(
            // ✅ IMPORTANT FIX
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  const Text(
                    "Tele Caller Dashboard",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D1B2A),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Consumer<TellCallViewmodel>(
                    builder: (context, vm, child) {
                      if (vm.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (vm.calldata == null) {
                        return const Text("No Data");
                      }

                      final data = vm.calldata!;

                      /// Dashboard Cards
                      return GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true, // ✅ IMPORTANT
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: itemAspectRatio,
                        children: [
                          _buildStatCard(
                            icon: Icons.phone_outlined,
                            iconColor: const Color(0xFF1A237E),
                            bgColor: const Color(0xFFE8EAF6),
                            value: data.totalData,
                            label: "Calls Today",
                            valueColor: const Color(0xFF1A237E),
                          ),
                          _buildStatCard(
                            icon: Icons.people_outline,
                            iconColor: const Color(0xFFB8860B),
                            bgColor: const Color(0xFFFFF9E6),
                            value: data.todaysCalls,
                            label: "Interested",
                            valueColor: const Color(0xFFB8860B),
                          ),
                          _buildStatCard(
                            icon: Icons.trending_up,
                            iconColor: const Color(0xFF2E7D32),
                            bgColor: const Color(0xFFE8F5E9),
                            value: data.montCalls,
                            label: "Site Visits",
                            valueColor: const Color(0xFF2E7D32),
                          ),
                          _buildStatCard(
                            icon: Icons.calendar_today_outlined,
                            iconColor: const Color(0xFFF9A825),
                            bgColor: const Color(0xFFFFFDE7),
                            value: data.totalCalls,
                            label: "Follow-ups Due",
                            valueColor: const Color(0xFFF9A825),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  /// ✅ CALL LIST SECTION ADDED
                  _buildCallListSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ================== STAT CARD ==================
  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// ================== CALL LIST ==================
  Widget _buildCallListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Call List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     border: Border.all(color: Colors.grey.shade300),
            //   ),
            //   child: const Row(
            //     children: [
            //       Icon(Icons.filter_list, size: 18),
            //       SizedBox(width: 6),
            //       Text("Filter"),
            //     ],
            //   ),
            // ),
          ],
        ),

        const SizedBox(height: 14),

        /// Chips
        Consumer<TeleSourceViewModel>(
  builder: (context, vm, child) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.sourceList.isEmpty) {
      return const Text("No Data");
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(vm.sourceList.length, (index) {
          final item = vm.sourceList[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              final sourceId = int.parse(item.id);

              context.read<CallListViewmodel>().fetchCalls(
                sourceId: sourceId,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildChip(item.name, selectedIndex == index),
            ),
          );
        }),
      ),
    );
  },
),

        const SizedBox(height: 16),

        /// Card
        /// Call List (Dynamic)
        Consumer<CallListViewmodel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.callList.isEmpty) {
              return const Text("No Data");
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vm.callList.length,
              itemBuilder: (context, index) {
                final data = vm.callList[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildCallCard(data),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildChip(String text, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFF3E0) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? const Color(0xFFF9A825) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? const Color(0xFFF9A825) : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildCallCard(CallListModel data) {
    return Container(
      padding: const EdgeInsets.all(12), // Reduced from 20
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18), // Slightly smaller radius
        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Name and Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.leadName,
                style: TextStyle(
                  fontSize: 18, // Reduced from 22
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ), // Smaller padding
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "High",
                  style: TextStyle(
                    color: Color(0xFFEF5350),
                    fontWeight: FontWeight.w600,
                    fontSize: 11, // Reduced from 14
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4), // Reduced from 8
          /// Phone Number
          Row(
            children: [
              Icon(Icons.phone_outlined, size: 14, color: Colors.grey.shade600),
              const SizedBox(width: 6),
              Text(
                "+91 ${data.leadMobile}",
                style: TextStyle(
                  fontSize: 13, // Reduced from 16
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6), // Reduced from 10
          /// Property Name
          Text(
            "GJKedia Signature Towers",
            style: TextStyle(
              fontSize: 14, // Reduced from 18
              color: Colors.blueGrey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10), // Reduced from 16
          /// Interested Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Interested",
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
                fontSize: 12, // Reduced
              ),
            ),
          ),

          const SizedBox(height: 12), // Reduced from 20
          /// Info Box (Grey)
          Container(
            padding: const EdgeInsets.all(10), // Reduced from 16
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Last Call",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        //"2 hours ago",
                        data.updatedTime,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next Follow-up",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        // "Today, 4:00 PM",
                        data.createdIn,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12), // Reduced from 20
          /// Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mode_comment_outlined,
                    size: 16,
                    color: Colors.black,
                  ),
                  label: const Text(
                    "Note",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ), // Reduced
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                     context.read<CallActionViewModel>().makeCallAndLog(data);
                  },
                  icon: const Icon(
                    Icons.phone_outlined,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Call Now",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF001A5E),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ), // Reduced
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
