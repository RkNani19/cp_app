import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gjk_cp/config/app_config.dart';
import 'package:gjk_cp/model/creative_model.dart';
import 'package:http/http.dart' as http;

class CreativesScreen extends StatefulWidget {
  const CreativesScreen({super.key});

  @override
  State<CreativesScreen> createState() => _CreateStateState();
}

class _CreateStateState extends State<CreativesScreen> {
  List<CreativeModel> allList = [];
  List<CreativeModel> filteredList = [];

  String selectedFilter = "All";

  @override
  void initState() {
    super.initState();
    fetchCreatives();
  }

  Future<void> fetchCreatives() async {
    final url = "${AppConfig.baseUrl}/mobileapp/creativesnew?start=0";

    /// 🔥 PRINT API URL
    print("API URL: $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);

      allList = data
          .map((e) => CreativeModel.fromJson(e))
          .where((e) => e.imageUrl.isNotEmpty)
          .toList();

      applyFilter("All");
    }
  }

  void applyFilter(String type) {
    selectedFilter = type;

    if (type == "All") {
      filteredList = allList;
    } else if (type == "Images") {
      filteredList = allList.where((e) => e.type == "image").toList();
    } else if (type == "PDFs") {
      filteredList = allList.where((e) => e.type == "pdf").toList();
    } else if (type == "Videos") {
      filteredList = allList.where((e) => e.type == "video").toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔷 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Marketing Creatives",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6ECF5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${filteredList.length} Files",
                      style: const TextStyle(
                        color: Color(0xFF0A2A6A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔷 FILTER CHIPS
              Row(
                children: [
                  GestureDetector(
                    onTap: () => applyFilter("All"),
                    child: FilterChipUI("All", selectedFilter == "All"),
                  ),
                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: () => applyFilter("Images"),
                    child: FilterChipUI("Images", selectedFilter == "Images"),
                  ),
                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: () => applyFilter("PDFs"),
                    child: FilterChipUI("PDFs", selectedFilter == "PDFs"),
                  ),
                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: () => applyFilter("Videos"),
                    child: FilterChipUI("Videos", selectedFilter == "Videos"),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔷 GRID
              Expanded(
                child: GridView.builder(
                  itemCount: filteredList.length,
                  // itemCount: 2,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.60,
                  ),
                  itemBuilder: (context, index) {
                    return CreativeCard(data: filteredList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔹 CARD
class CreativeCard extends StatelessWidget {
  final CreativeModel data;

  const CreativeCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔷 IMAGE + PDF BADGE
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
                child: Image.network(
                  // "https://picsum.photos/400/300",
                  data.imageUrl,
                  height: 150, // 🔥 IMPORTANT (match design)
                  width: double.infinity,
                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image, size: 150),
                    );
                  },
                ),
              ),

              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    //"PDF",
                    data.type.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// 🔷 CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  const Text(
                    "GJKedia Signature Towers Brochure",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),

                  const SizedBox(height: 4),

                  /// FILE SIZE
                  Text(
                    "2.4 MB",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),

                  // const Spacer(),
                  // SizedBox(height: 4,),

                  /// 🔷 BUTTONS
                  Row(
                    children: [
                      /// DOWNLOAD
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.download, size: 16),
                              //SizedBox(height: 4),
                              Text("Download"),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      /// SHARE
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A2A6A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(Icons.share, color: Colors.white, size: 18),
                              SizedBox(width: 2),
                              Text(
                                "Share",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 FILTER CHIP
class FilterChipUI extends StatelessWidget {
  final String text;
  final bool selected;

  const FilterChipUI(this.text, this.selected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          color: selected ? const Color(0xFFB0892F) : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
