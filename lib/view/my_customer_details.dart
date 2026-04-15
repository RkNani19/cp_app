import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gjk_cp/model/customer_model.dart';
import 'package:permission_handler/permission_handler.dart';

class MyCustomerDetails extends StatelessWidget {
  final CustomerModel customer; // ✅ ADD

  const MyCustomerDetails({super.key, required this.customer});

  // Method to handle the call logic
  _callCustomer(BuildContext context) async {
    String phoneNumber = "+91${customer.mobile}"; // The customer's phone number

    // 1. Check for phone permission
    var status = await Permission.phone.status;

    // 2. If permission is not granted, request it
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }

    // 3. If permission is granted, make the direct call
    if (status.isGranted) {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } else {
      // 4. If permission is denied, show a message to the user
      // You can also use a dialog to ask the user to go to settings
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Phone permission is required to make a call.'),
          action: SnackBarAction(
            label: 'SETTINGS',
            onPressed: () {
              // Opens the app settings
              openAppSettings();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // I'm using the corrected code from the previous request with full-width cards
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... (Back button, Profile card, etc. - code remains the same)
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back, color: Color(0xFF0A2A6A)),
                    SizedBox(width: 6),
                    Text(
                      "Back to Customers",
                      style: TextStyle(
                        color: Color(0xFF0A2A6A),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A2A6A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB0892F),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "+91 ${customer.mobile}",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        SizedBox(height: 2),
                        Text(
                          customer.email.isEmpty ? "-" : customer.email,
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.project,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "GJKedia Royal Heights",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     "Status",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7E6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:  Text(
                        customer.activity,
                        style: TextStyle(
                          color: Color(0xFFB0892F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             // const Spacer(),

             SizedBox(height: 20,),

              /// 📞 Call Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  // UPDATED onPressed
                  onPressed: () {
                    _callCustomer(context);
                  },
                  icon: const Icon(Icons.call, color: Colors.white),
                  label: const Text(
                    "Call Customer",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A2A6A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              // ... (Other buttons remain the same)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.email, color: Color(0xFF0A2A6A)),
                  label: const Text(
                    "Send Email",
                    style: TextStyle(color: Color(0xFF0A2A6A)),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF0A2A6A)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  label: const Text(
                    "Schedule Meeting",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB0892F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
