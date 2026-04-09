import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/banner_model.dart';
import 'package:http/http.dart' as http;

class BannerViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<BannerModel> banners = [];

  Future<void> fetchBanners() async {
    try {
      print("🔥 API CALL STARTED");

      isLoading = true;
      notifyListeners();

      // ✅ USING BASE URL
     final url =
    "${AppConfig.baseUrl}/customerapp/menunextp?project_id=1&start=0";

      print("👉banner URL: $url");

      final response = await http.get(Uri.parse(url));

      print("👉 STATUS CODE: ${response.statusCode}");
      print("👉 RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);

        banners = data
            .map((e) => BannerModel.fromJson(e))
            .toList();

        print("✅ BANNERS COUNT: ${banners.length}");

        // 🔥 PRINT EACH ITEM
        for (var banner in banners) {
          print("📛 NAME: ${banner.name}");
          print("🖼 IMAGE: ${banner.image}");
        }
      } else {
        print("❌ API FAILED");
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("❌ ERROR: $e");
    }
  }
}