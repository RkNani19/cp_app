import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/model/enquiry_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
 
import 'package:gjk_cp/config/app_config.dart'; // adjust path

class EnquiryViewModel extends ChangeNotifier {
  
  // 🔷 STATE
  bool isLoading = false;
  String? errorMessage;
  EnquiryResponseModel? enquiryResponse;

  // 🔥 SUBMIT ENQUIRY
  Future<bool> submitEnquiry({
    required String projectId,
    required String name,
    required String mobile,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // 🔥 GET user_id FROM SHARED PREFERENCES
      final prefs = await SharedPreferences.getInstance();
      final String userId = (prefs.getInt("cpId")).toString();

      final Uri url = Uri.parse(
        "${AppConfig.baseUrl}/customerapp/customerEnquiries"
        "?user_id=$userId"
        "&product_id=$projectId",
      );

// 🔥 PRINT URL BEFORE CALLING
    debugPrint("📤 Enquiry API URL: $url");
    debugPrint("📤 Params → user_id: $userId | product_id: $projectId | name: $name | mobile: $mobile");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        enquiryResponse = EnquiryResponseModel.fromJson(data[0]);

        if (enquiryResponse!.status == 1) {
          return true; // ✅ Success
        } else {
          errorMessage = enquiryResponse!.msg;
          return false;
        }
      } else {
        errorMessage = "Server error: ${response.statusCode}";
        return false;
      }
    } catch (e) {
      errorMessage = "Something went wrong: $e";
      debugPrint('EnquiryViewModel Error: $e');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 🔷 RESET STATE
  void reset() {
    isLoading = false;
    errorMessage = null;
    enquiryResponse = null;
    notifyListeners();
  }
}