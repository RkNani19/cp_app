import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gjk_cp/view/dashboard_screen.dart';
import 'package:gjk_cp/viewmodel/callus_viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CallUs extends StatefulWidget {
  const CallUs({super.key, required this.title});
  final String title;

  @override
  State<CallUs> createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<CallusViewmodel>(context, listen: false).fetchOfficeDetails();
  }

  /// 🔥 Reusable Contact Card
  Widget contactCard({
    required String title,
    required String tag,
    required String phone,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(tag)],
          ),

          const SizedBox(height: 8),

          Text(phone),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: () {
                makeDirectCall(phone); // 🔥 THIS IS THE FIX
              },
              icon: const Icon(Icons.call, size: 18),
              label: const Text("Call Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF021148),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
            
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen(title: '')),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: Consumer<CallusViewmodel>(
            builder: (context, vm, child) {
              /// 🔥 LOADING
              if (vm.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              /// 🔥 ERROR
              if (vm.error.isNotEmpty) {
                return Center(child: Text(vm.error));
              }

              /// 🔥 NO DATA
              if (vm.office == null) {
                return const Center(child: Text("No Data Found"));
              }

              final office = vm.office!;

              /// 🔥 MAIN UI
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔹 Title
                      const Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D1B2A),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// 🔹 Cards
                      contactCard(
                        title: office.salesName,
                        tag: "Primary",
                        phone: office.saleMobile,
                      ),

                      contactCard(
                        title: office.csName,
                        tag: "Support",
                        phone: office.csMobile,
                      ),

                      contactCard(
                        title: office.svbName,
                        tag: "Booking",
                        phone: office.svbMobile,
                      ),

                      const SizedBox(height: 10),

                      /// 🔹 Head Office Card
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF021148),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Head Office",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// Address
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    // "GJKedia Homes, 123 Business Tower, Bandra Kurla Complex, Mumbai - 400051",
                                    office.address,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 14),

                            /// Email
                            Row(
                              children: [
                                Icon(Icons.mail_outline, color: Colors.white70),
                                SizedBox(width: 10),
                                Text(
                                  // "info@gjkediahomes.com",
                                  office.email,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 14),

                            /// Working Hours
                            Row(
                              children: [
                                Icon(Icons.access_time, color: Colors.white70),
                                SizedBox(width: 10),
                                Text(
                                  // "Mon - Sat: 10:00 AM - 7:00 PM",
                                  office.timing,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> makeDirectCall(String number) async {
    if (number.isEmpty) return;

    // 🔥 Ask Permission
    PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {
      bool? res = await FlutterPhoneDirectCaller.callNumber(number);
      print("Calling: $number, Result: $res");
    } else if (status.isDenied) {
      print("Permission Denied");
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}