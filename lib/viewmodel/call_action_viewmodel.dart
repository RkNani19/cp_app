import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/call_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class CallActionViewModel extends ChangeNotifier {
  bool isCalling = false;


  

Future<void> makeCallAndLog(CallListModel data) async {
  isCalling = true;
  notifyListeners();

  try {
    // ✅ 1. CALL FIRST (instant)
    await _makeDirectCall(data.leadMobile);

    // ✅ 2. THEN API (background)
    await _insertCallLog(data);

  } catch (e) {
    print("ERROR: $e");
  }

  isCalling = false;
  notifyListeners();
}

  /// 🔥 DIRECT CALL
Future<void> _makeDirectCall(String phoneNumber) async {
  print("TRYING TO CALL: $phoneNumber");

  final status = await Permission.phone.request();

  print("PERMISSION: $status");

  if (status.isGranted) {
    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);

    print("CALL RESULT: $res"); // 🔥 IMPORTANT
  } else {
    print("Permission denied");
  }
}

Future<void> _insertCallLog(CallListModel data) async {
  final prefs = await SharedPreferences.getInstance();
  final cpId = prefs.getInt("cpId") ?? 0;

  final now = DateTime.now();
  final date =
      "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

  final url =
      "${AppConfig.baseUrl}/mobileapp/cptelecalercallsinsert"
      "?cp_id=$cpId"
      "&lead_id=${data.callerId}"
      "&created_by=$cpId"
      "&call_date=$date"
      "&customer_name=${data.leadName}"
      "&mobile_number=${data.leadMobile}"
      "&country_code=91"
      "&duration=0";

  print("API: $url");

  try {
    final response = await http.get(Uri.parse(url));
    print("API RESPONSE: ${response.body}");
  } catch (e) {
    print("API ERROR: $e");
  }
}


}