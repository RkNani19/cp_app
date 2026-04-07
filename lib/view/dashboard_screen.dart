import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.title});
  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Used the specific off-white/grey background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeroBanner(),
              SizedBox(height: 20),
              SearchBarWidget(),
              SizedBox(height: 24),
              SectionHeader(title: "Featured Projects", showViewAll: true),
              SizedBox(height: 12),
              FeaturedProjectsList(),
              SizedBox(height: 24),
              SectionHeader(title: "Quick Actions", showViewAll: false),
              SizedBox(height: 12),
              QuickActionsGrid(),
              SizedBox(height: 24),
              SectionHeader(title: "Special Offers", showViewAll: false),
              SizedBox(height: 12),
              SpecialOffersSection(),
              SizedBox(height: 24),
              SectionHeader(title: "Recent Activity", showViewAll: true),
              SizedBox(height: 12),
              RecentActivityList(),
              SizedBox(height: 40), // Extra padding at the bottom for scrolling
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// COLOR PALETTE & STYLES
// ============================================================================
class AppColors {
  static const Color background = Color(0xFFF7F9FC);
  static const Color primaryDark = Color(0xFF0C2054);
  static const Color accentGold = Color(0xFFC49A50);
  static const Color textGrey = Color(0xFF6C757D);
  static const Color lightGrey = Color(0xFFE9ECEF);
  static const Color white = Colors.white;
}

// ============================================================================
// UI COMPONENTS
// ============================================================================

class HeroBanner extends StatelessWidget {
  const HeroBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          // TODO: Replace NetworkImage with AssetImage if you have local images
          image: NetworkImage('https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?q=80&w=1000&auto=format&fit=crop'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8), // Darkens the bottom for text readability
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "GJKedia Signature Towers",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.white70, size: 14),
                const SizedBox(width: 4),
                Text(
                  "Kandivali West, Mumbai",
                  style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Starting from", style: TextStyle(color: Colors.white70, fontSize: 10)),
                    Text(
                      "₹2.45 Cr",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentGold,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    minimumSize: const Size(0, 36),
                  ),
                  child: Row(
                    children: const [
                      Text("View Project", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 14),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search by location, project, BHK...",
          hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 13),
          prefixIcon: Icon(Icons.search, color: AppColors.textGrey, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final bool showViewAll;

  const SectionHeader({Key? key, required this.title, required this.showViewAll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: AppColors.primaryDark, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        if (showViewAll)
          Text(
            "View All",
            style: TextStyle(color: AppColors.accentGold.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w600),
          ),
      ],
    );
  }
}

class FeaturedProjectsList extends StatelessWidget {
  const FeaturedProjectsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2, // Number of horizontal cards
        itemBuilder: (context, index) {
          return Container(
            width: 240,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.lightGrey, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  // TODO: Replace NetworkImage with your own AssetImage
                  child: Image.network(
                    'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?q=80&w=1000&auto=format&fit=crop', 
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "GJKedia Signature Towers",
                        style: TextStyle(color: AppColors.primaryDark, fontSize: 13, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: const [
                          Icon(Icons.location_on_outlined, color: AppColors.textGrey, size: 12),
                          SizedBox(width: 4),
                          Text("Kandivali West, Mumbai", style: TextStyle(color: AppColors.textGrey, fontSize: 10)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Starting from", style: TextStyle(color: AppColors.textGrey, fontSize: 9)),
                              Text("₹2.45 Cr", style: TextStyle(color: AppColors.primaryDark, fontSize: 14, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryDark,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              minimumSize: const Size(0, 28),
                            ),
                            child: const Text("View", style: TextStyle(fontSize: 11)),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actions = [
      {"icon": Icons.person_add_outlined, "label": "Add Customer"},
      {"icon": Icons.history, "label": "Sales History"},
      {"icon": Icons.people_outline, "label": "My Customers"},
      {"icon": Icons.person_add_alt_1_outlined, "label": "Create Associate"},
      {"icon": Icons.photo_library_outlined, "label": "Creatives"},
      {"icon": Icons.share_outlined, "label": "Share App Link"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.lightGrey, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F4FA),
                  shape: BoxShape.circle,
                ),
                child: Icon(actions[index]["icon"] as IconData, color: AppColors.primaryDark, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                actions[index]["label"] as String,
                style: const TextStyle(color: AppColors.primaryDark, fontSize: 11, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

class SpecialOffersSection extends StatelessWidget {
  const SpecialOffersSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Offer Card 1
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F4E6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.accentGold.withOpacity(0.3), width: 1),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -10,
                top: -10,
                child: Icon(Icons.star, size: 80, color: AppColors.accentGold.withOpacity(0.15)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.card_giftcard, size: 16, color: AppColors.accentGold),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.accentGold, borderRadius: BorderRadius.circular(4)),
                        child: const Text("LIMITED TIME", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text("Festive Season Offer", style: TextStyle(color: AppColors.primaryDark, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text("Get up to ₹2 Lakhs off on bookings\nthis month.", style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text("View Details", style: TextStyle(color: AppColors.accentGold, fontSize: 11, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward, size: 12, color: AppColors.accentGold),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Offer Card 2
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEBF0F6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primaryDark.withOpacity(0.1), width: 1),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.trending_up, size: 60, color: AppColors.primaryDark.withOpacity(0.08)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.flash_on, size: 16, color: AppColors.primaryDark),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.primaryDark, borderRadius: BorderRadius.circular(4)),
                        child: const Text("FLASH DEAL", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text("Zero Down Payment", style: TextStyle(color: AppColors.primaryDark, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text("Book your dream home with zero\ndown payment.", style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text("Learn More", style: TextStyle(color: AppColors.primaryDark, fontSize: 11, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward, size: 12, color: AppColors.primaryDark),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        "icon": Icons.person,
        "iconColor": const Color(0xFF5D3E8C), // Matched from image
        "title": "New Lead Added",
        "desc": "Amit Sharma - GJKedia Signature Towers",
        "time": "2 hours ago"
      },
      {
        "icon": Icons.location_on,
        "iconColor": const Color(0xFFD34F73), // Matched from image
        "title": "Site Visit Completed",
        "desc": "Priya Patel visited Prime Residency",
        "time": "6 hours ago"
      },
      {
        "icon": Icons.shopping_bag,
        "iconColor": AppColors.accentGold,
        "title": "Sale Closed",
        "desc": "₹2.45 Cr - Signature Towers (3 BHK)",
        "time": "1 day ago"
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.lightGrey, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                child: Icon(activity["icon"] as IconData, color: activity["iconColor"] as Color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(activity["title"] as String, style: const TextStyle(color: AppColors.primaryDark, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(activity["desc"] as String, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
                    const SizedBox(height: 6),
                    Text(activity["time"] as String, style: const TextStyle(color: AppColors.textGrey, fontSize: 9)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}