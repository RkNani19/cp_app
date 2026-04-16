import 'package:flutter/material.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key, required this.title});
  final String title;

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final String facebookPackage = "com.facebook.katana";
  final String instagramPackage = "com.instagram.android";
  final String twitterPackage = "com.twitter.android";

  String cpId = "";

  @override
  void initState() {
    super.initState();
    loadCpId();
  }

  String get shareText {
    if (cpId.isEmpty) return "Loading...";

    return "Join using my referral code: $cpId\nhttps://gjkediahomes.app/partner?ref=$cpId";
  }

  Future<bool> isAppInstalled(String packageName) async {
    return await FlutterDeviceApps.openApp(packageName);
  }

  Future<void> openAppOrStore({
    required String appUrl,
    required String packageName,
  }) async {
    final Uri uri = Uri.parse(appUrl);

    try {
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw "App not opened";
      }
    } catch (e) {
      /// 🔥 OPEN PLAY STORE
      final playStoreUrl = Uri.parse(
        "https://play.google.com/store/apps/details?id=$packageName",
      );

      await launchUrl(playStoreUrl, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> shareToWhatsApp() async {
    final url = Uri.parse(
      "https://wa.me/?text=${Uri.encodeComponent(shareText)}",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> shareToFacebook() async {
    bool installed = await isAppInstalled(facebookPackage);

    if (installed) {
      final url = Uri.parse(
        "fb://facewebmodal/f?href=${Uri.encodeComponent(shareText)}",
      );

      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      final playStoreUrl = Uri.parse(
        "https://play.google.com/store/apps/details?id=$facebookPackage",
      );

      await launchUrl(playStoreUrl, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> shareToInstagram() async {
    bool installed = await isAppInstalled(instagramPackage);

    if (installed) {
      Share.share(shareText); // Instagram uses share dialog
    } else {
      final playStoreUrl = Uri.parse(
        "https://play.google.com/store/apps/details?id=$instagramPackage",
      );

      await launchUrl(playStoreUrl, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> shareToTwitter() async {
    bool installed = await isAppInstalled(twitterPackage);

    if (installed) {
      final url = Uri.parse(
        "twitter://post?message=${Uri.encodeComponent(shareText)}",
      );

      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      final playStoreUrl = Uri.parse(
        "https://play.google.com/store/apps/details?id=$twitterPackage",
      );

      await launchUrl(playStoreUrl, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> loadCpId() async {
    final prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt("cpId");

    setState(() {
      cpId = id?.toString() ?? "";
    });

    /// 🔥 DEBUG
    print("CP ID: $cpId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF5F6FA),
        title: const Text(
          "Share App & Earn",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔵 Referral Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0A2A6A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Referral Code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    "Share this code with other agents",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Code Box
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            // "GJKED-CP2024-001",
                            cpId.isEmpty ? "Loading..." : cpId,
                            style: TextStyle(
                              color: Color(0xFFD4AF37),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(Icons.copy, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔗 Personal Link Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Personal Link",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F3F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        // Expanded(
                        //   child: Text(
                        //     "https://gjkediahomes.app/partner",
                        //     style: TextStyle(fontSize: 13),
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                        Icon(Icons.copy, size: 18),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Share Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Share.share(shareText);
                      },
                      icon: const Icon(Icons.share, color: Colors.white),
                      label: const Text(
                        "Share Link",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A2A6A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 📱 Social Media
            const Text(
              "Share on Social Media",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: shareToWhatsApp,
                  child: const SocialItem(
                    icon: Icons.chat,
                    color: Colors.green,
                    label: "WhatsApp",
                  ),
                ),

                GestureDetector(
                  onTap: shareToFacebook,
                  child: const SocialItem(
                    icon: Icons.facebook,
                    color: Colors.blue,
                    label: "Facebook",
                  ),
                ),

                GestureDetector(
                  onTap: shareToInstagram,
                  child: const SocialItem(
                    icon: Icons.camera_alt,
                    color: Colors.pink,
                    label: "Instagram",
                  ),
                ),

                GestureDetector(
                  onTap: shareToTwitter,
                  child: const SocialItem(
                    icon: Icons.alternate_email,
                    color: Colors.lightBlue,
                    label: "Twitter",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// 💰 Benefits
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F5EC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orange.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Referral Benefits",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: 12),

                  BenefitItem("Earn ₹5,000 for every successful referral"),
                  BenefitItem("Get bonus incentives on team performance"),
                  BenefitItem("Unlock exclusive rewards and recognition"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Social Item
class SocialItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const SocialItem({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Center(child: Icon(icon, color: color, size: 30)),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

/// 🔹 Benefit Item
class BenefitItem extends StatelessWidget {
  final String text;
  const BenefitItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text, // ✅ FIXED
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
