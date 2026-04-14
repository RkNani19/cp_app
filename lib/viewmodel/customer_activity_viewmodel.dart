import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/customer_activity_model.dart';
import 'package:gjk_cp/model/customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomerActivityViewmodel extends ChangeNotifier {
  List<CustomerActivityModel> activities = [];
  bool isLoading = false;
  int page = 0;
  bool hasMoreData = true;
  bool isLoadingMore = false;

  List<CustomerModel> customers = [];
  bool isCustomerLoading = false;

  String selectedActivity = "All";

  Future<void> fetchActivities() async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final companyId = prefs.getInt("companyId") ?? 1; // ✅ dynamic

      final url =
          "${AppConfig.baseUrl}/mobileapp/activities?company_id=$companyId";

      print("Customer Activity URL 👉 $url");

      final response = await http.get(Uri.parse(url));

      //  print("ACTIVITY API 👉 ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        activities = data
            .map<CustomerActivityModel>(
              (e) => CustomerActivityModel.fromJson(e),
            )
            .toList();

        // ✅ Add "All"
        activities.insert(0, CustomerActivityModel(id: "0", name: "All"));
      }
    } catch (e) {
      print("ERROR 👉 $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void selectActivity(String name) {
    selectedActivity = name;
    notifyListeners();
  }

  Future<void> fetchCustomers(
    String activityId, {
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      if (isLoadingMore || !hasMoreData) return;
      isLoadingMore = true;
    } else {
      page = 0;
      hasMoreData = true;
      customers.clear();
      isCustomerLoading = true;
    }

    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final cpId = prefs.getInt("cpId") ?? 0;

      final url =
          "${AppConfig.baseUrl}/mobileapp/getcpleadsdata2026"
          "?cp_id=$cpId&activity_id=$activityId&start=$page";

      print("CUSTOMER API 👉 $url");

      final response = await http.get(Uri.parse(url));

     // print("CUSTOMER RESPONSE 👉 ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data.isEmpty) {
          hasMoreData = false; // ❌ no more data
        } else {
          final newList = data
              .map<CustomerModel>((e) => CustomerModel.fromJson(e))
              .toList();

          customers.addAll(newList); // ✅ append

          page++; // 🔥 increment page
        }
      }
    } catch (e) {
      print("ERROR 👉 $e");
    }

    isCustomerLoading = false;
    isLoadingMore = false;
    notifyListeners();
  }
}
