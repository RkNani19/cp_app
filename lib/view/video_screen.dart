import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

// Dummy DashboardScreen for navigation to work.
// You can replace this with your actual DashboardScreen import.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: const Center(child: Text("Dashboard Screen")),
    );
  }
}

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.title});
  final String title;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  // 🔥 FILTER CATEGORIES
  final List<String> _categories = [
    "All",
    "Property Tour",
    "Amenities",
    "Township",
  ];
  String _selectedCategory = "All";

  // 🔥 DUMMY VIDEO DATA
  // This data is set up to match the first card in the screenshot.
  final List<Map<String, String>> _videos = [
    {
      "category": "Property Tour",
      "title": "GJKedia Signature Towers - Virtual Tour",
      "views": "2.4K views",
      "duration": "4:32",
      "thumbnail":
          "https://i.imgur.com/8pPnj8X.png", // Using a static image to match screenshot
    },
    {
      "category": "Amenities",
      "title": "World Class Amenities at GJKedia Homes",
      "views": "1.8K views",
      "duration": "3:15",
      "thumbnail": "https://picsum.photos/seed/gjk2/600/340",
    },
    {
      "category": "Township",
      "title": "GJKedia Township - A Complete Lifestyle",
      "views": "3.1K views",
      "duration": "6:10",
      "thumbnail": "https://picsum.photos/seed/gjk3/600/340",
    },
    {
      "category": "Property Tour",
      "title": "Luxury Villas - Walkthrough 2024",
      "views": "980 views",
      "duration": "5:45",
      "thumbnail": "https://picsum.photos/seed/gjk4/600/340",
    },
    {
      "category": "Amenities",
      "title": "Swimming Pool & Clubhouse Tour",
      "views": "1.2K views",
      "duration": "2:55",
      "thumbnail": "https://picsum.photos/seed/gjk5/600/340",
    },
    {
      "category": "Township",
      "title": "GJKedia Green Township Overview",
      "views": "750 views",
      "duration": "4:00",
      "thumbnail": "https://picsum.photos/seed/gjk6/600/340",
    },
  ];

  // 🔥 FILTERED LIST
  List<Map<String, String>> get _filteredVideos {
    if (_selectedCategory == "All") return _videos;
    return _videos.where((v) => v["category"] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(title: ''),
          ),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ========== HEADER ==========
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Videos",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF212529),
                          ),
                        ),

                        /// VIDEO COUNT BADGE
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBEBFF),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "${_videos.length} Videos",
                            style: const TextStyle(
                              color: Color(0xFF4338CA),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// ========== FILTER CHIPS ==========
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _categories.map((category) {
                          final bool isSelected = _selectedCategory == category;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedCategory = category);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFD4B483) // Tan Gold color
                                    : Colors.white,
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFFD4B483)
                                      : Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ========== VIDEO LIST ==========
              Expanded(
                child: _filteredVideos.isEmpty
                    ? const Center(
                        child: Text(
                          "No videos found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredVideos.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 24),
                        itemBuilder: (context, index) {
                          final video = _filteredVideos[index];
                          return videoCard(video);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ========== VIDEO CARD WIDGET ==========
  Widget videoCard(Map<String, String> video) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// THUMBNAIL AREA
            Stack(
              alignment: Alignment.center,
              children: [
                /// IMAGE
                Image.network(
                  video["thumbnail"]!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),

                /// PLAY BUTTON (center)
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Color(0xFF0D1B6F),
                    size: 36,
                  ),
                ),

                /// CATEGORY BADGE (top left)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4B483),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      video["category"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                /// DURATION BADGE (bottom right)
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          video["duration"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// INFO & BUTTONS AREA
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    video["title"]!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212529),
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// VIEWS
                  Text(
                    video["views"]!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 16),

                  /// ACTION BUTTONS
                  Row(
                    children: [
                      /// DOWNLOAD
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download_outlined, size: 20),
                          label: const Text("Download"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF343A40),
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      /// SHARE
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Share.share('${video["title"]}\nCheck this video!');
                          },
                          icon: const Icon(
                            Icons.share,
                            size: 20,
                          ), // This icon is a close match
                          label: const Text("Share"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D1B6F),
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
