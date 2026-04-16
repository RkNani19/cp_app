import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:gjk_cp/config/app_config.dart';

class AvailabilityScreen extends StatefulWidget {
  final String projectId;
  final String projectName;

  const AvailabilityScreen({
    super.key,
    required this.projectId,
    required this.projectName,
  });

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    final url =
        "${AppConfig.baseUrl}/mobileapp/checkavailability6?project_id=${widget.projectId}";

    debugPrint("WebView URL: $url");

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Availability - ${widget.projectName}"),
        backgroundColor: const Color(0xFF0A2A6A),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),

          /// 🔷 LOADING INDICATOR
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
