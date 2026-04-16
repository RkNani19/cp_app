import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:http/http.dart' as http;
import '../model/video_model.dart';

class VideoViewModel extends ChangeNotifier {
  List<VideoModel> videos = [];
  bool isLoading = false;

  Future<void> fetchVideos() async {
    isLoading = true;
    notifyListeners();

    try {
      final url = "${AppConfig.baseUrl}/customerapp/getprojectslistsvideos";

      print("VIDEO API URL: $url"); // ✅ Correct URL print

      final response = await http.get(Uri.parse(url));

      print("VIDEO API RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        videos = data.map<VideoModel>((e) => VideoModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("VIDEO ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
