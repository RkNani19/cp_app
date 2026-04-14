import 'package:flutter/material.dart';
import 'package:gjk_cp/model/customer_model.dart';
import 'package:gjk_cp/viewmodel/customer_activity_viewmodel.dart';
import 'package:provider/provider.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final vm = Provider.of<CustomerActivityViewmodel>(context, listen: false);

      vm.fetchActivities();
      vm.fetchCustomers("0"); // default load
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        final vm = Provider.of<CustomerActivityViewmodel>(
          context,
          listen: false,
        );

        vm.fetchCustomers(
          vm.selectedActivity == "All"
              ? "0"
              : vm.activities
                    .firstWhere((e) => e.name == vm.selectedActivity)
                    .id,
          isLoadMore: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF5F6FA),
        title: const Text(
          "My Customers",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE6ECF5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Consumer<CustomerActivityViewmodel>(
              builder: (context, vm, child) {
                return Center(
                  child: Text(
                    "${vm.activities.length} Total",
                    style: const TextStyle(
                      color: Color(0xFF0A2A6A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          /// 🔘 Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer<CustomerActivityViewmodel>(
              builder: (context, vm, child) {
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: vm.activities.map((activity) {
                      final isSelected = vm.selectedActivity == activity.name;

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            vm.selectActivity(activity.name);
                            vm.fetchCustomers(activity.id);
                          },
                          child: FilterChipUI(activity.name, isSelected),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          /// 🔽 List
          Expanded(
            child: Consumer<CustomerActivityViewmodel>(
              builder: (context, vm, child) {
                if (vm.isCustomerLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (vm.customers.isEmpty) {
                  return const Center(child: Text("No Customers"));
                }

                return ListView.builder(
                  controller: _scrollController, // ✅ IMPORTANT
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount:
                      vm.customers.length +
                      (vm.isLoadingMore ? 1 : 0), // loader at bottom
                  itemBuilder: (context, index) {
                    if (index < vm.customers.length) {
                      final customer = vm.customers[index];
                      return CustomerCard(customer: customer);
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 Customer Card
class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key, required this.customer});
  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row
          Row(
            children: [
              /// Avatar
              Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  color: Color(0xFFB0892F),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),

              const SizedBox(width: 12),

              /// Name + Phone + Email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(Icons.call, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          "+91 ${customer.mobile}",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),

                    SizedBox(height: 2),

                    Row(
                      children: [
                        Icon(Icons.email, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          customer.email.isEmpty ? "-" : customer.email,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Status
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5E8C7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  customer.activity,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFB0892F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// Location
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey),
              SizedBox(width: 6),
              Text(
                customer.project,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// Date
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              SizedBox(width: 6),
              Text("Added on ${customer.date}"),
            ],
          ),

          const SizedBox(height: 12),

          /// Interest Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text("Interested in 3 BHK"),
          ),

          const SizedBox(height: 14),

          const Divider(),

          const SizedBox(height: 10),

          /// Buttons
          Row(
            children: [
              /// Edit
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text("Edit"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              /// Call
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ), // ✅ icon white
                  label: const Text(
                    "Call",
                    style: TextStyle(color: Colors.white), // ✅ text white
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A2A6A), // ✅ button bg
                    foregroundColor:
                        Colors.white, // ✅ ensures text + icon white
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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

/// 🔹 Filter Chip
class FilterChipUI extends StatelessWidget {
  final String text;
  final bool selected;

  const FilterChipUI(this.text, this.selected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFF5E8C7) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? const Color(0xFFB0892F) : Colors.grey.shade300,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: selected ? const Color(0xFFB0892F) : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
