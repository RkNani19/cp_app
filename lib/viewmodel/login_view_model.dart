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
    // ✅ Save login status
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", true);

    return true;
  } else {
    return false;
  }
}
}