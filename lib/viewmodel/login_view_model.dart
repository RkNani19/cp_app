import 'package:flutter/material.dart';
import 'package:gjk_cp/model/login_model.dart';
import 'package:gjk_cp/services/login_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginService _service = LoginService();

  bool isLoading = false;
  LoginModel? user;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    user = await _service.login(email, password);

    isLoading = false;
    notifyListeners();

    if (user != null && user!.status == 1) {
      final prefs = await SharedPreferences.getInstance();

      // ✅ Basic
      await prefs.setBool("isLoggedIn", true);

      // ✅ OLD DATA
      await prefs.setInt("cpId", user!.cpId);
      await prefs.setString("userName", user!.userName);
      await prefs.setString("mobile", user!.mobile);

      // 🔥 NEW DATA
      await prefs.setString("userEmail", user!.userEmail);
      await prefs.setString("agentUniqueId", user!.agentUniqueId);
      await prefs.setString("agentAddress", user!.agentAddress);
      await prefs.setString("panCard", user!.panCard);
      await prefs.setString("aadharNumber", user!.aadharNumber);

      return true;
    } else {
      return false;
    }
  }
}
