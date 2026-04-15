import 'package:flutter/material.dart';
import 'package:gjk_cp/model/banner_model.dart';
import 'package:gjk_cp/model/fetch_project_model.dart';
import 'package:gjk_cp/view/add_customer.dart';
import 'package:gjk_cp/view/create_associate.dart';
import 'package:gjk_cp/view/creatives.dart';
import 'package:gjk_cp/view/customer.dart';
import 'package:gjk_cp/view/sale_history.dart';
import 'package:gjk_cp/view/share.dart';
import 'package:gjk_cp/view/view_all_projects.dart';
import 'package:gjk_cp/viewmodel/banner_viewmodel.dart';
import 'package:gjk_cp/viewmodel/feth_project_viewmodel.dart';
import 'package:provider/provider.dart';

/// ================= COLORS =================
class AppColors {
  static const Color background = Color(0xFFF7F9FC);
  static const Color primaryDark = Color(0xFF00155B);
  static const Color accentGold = Color(0xFFC49A50);
  static const Color textGrey = Color(0xFF6C757D);
  static const Color lightGrey = Color(0xFFE9ECEF);
  static const Color white = Colors.white;
}

/// ================= HOME SCREEN =================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();

    // 🔥 CALL API HERE
    Future.microtask(() {
      Provider.of<BannerViewModel>(context, listen: false).fetchBanners();
      Provider.of<FethProjectViewmodel>(context, listen: false).fetchProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(child: HomeContent()),
    );
  }
}

/// ================= HOME CONTENT =================
class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<BannerViewModel>(
              builder: (context, vm, child) {
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (vm.banners.isEmpty) {
                  return const Text("No Data");
                }

                return HeroBanner(
                  banner: vm.banners[0], // 🔥 API DATA HERE
                );
              },
            ),
            SizedBox(height: 20),
            SearchBarWidget(),
            SizedBox(height: 24),
            SectionHeader(title: "Featured  ", showViewAll: true),
            SizedBox(height: 12),
            // FeaturedProjectsList(),
            Consumer<FethProjectViewmodel>(
              builder: (context, projectVm, child) {
                if (projectVm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (projectVm.projects.isEmpty) {
                  return const Text("No Data");
                }

                return FeaturedProjectsList(projects: projectVm.projects);
              },
            ),

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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/// ================= HERO BANNER =================
class HeroBanner extends StatelessWidget {
  final BannerModel banner;
  const HeroBanner({Key? key, required this.banner}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(banner.image),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            debugPrint("Image failed: ${banner.image}");
          },
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          // color: AppColors.white.withOpacity(0.10),
          border: Border.all(color: AppColors.lightGrey, width: 1),
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
            colors: [Colors.transparent, Colors.black.withOpacity(0)],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              banner.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  //"Kandivali West, Mumbai",
                  banner.location,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 12,
                  ),
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
                  children: [
                    Text(
                      "Starting from",
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee_sharp,
                          color: Colors.black.withOpacity(0.9),
                          size: 14,
                        ),
                        SizedBox(width: 2),
                        Text(
                          // "₹2.45 Cr",
                          banner.price,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentGold,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    minimumSize: const Size(0, 36),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        "View Project",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= SEARCH =================
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

/// ================= HEADER =================
class SectionHeader extends StatelessWidget {
  final String title;
  final bool showViewAll;
    final VoidCallback? onViewAllTap;
  const SectionHeader({
    Key? key,
    required this.title,
    required this.showViewAll,
     this.onViewAllTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.primaryDark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (showViewAll)
        GestureDetector(
          onTap:  () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewAllProjects(),
      ),
    );
  },
       child: Text(
            "View All",
            style: TextStyle(
              color: AppColors.accentGold.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}

/// ================= FEATURED =================
class FeaturedProjectsList extends StatelessWidget {
  final List<FetchProjectModel> projects;
  const FeaturedProjectsList({Key? key, required this.projects})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return Container(
            width: 240,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.lightGrey, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    project.image,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,

                    /// ✅ HANDLE ERROR
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // "GJKedia Signature Towers",
                        project.name,
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.textGrey,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            // "Kandivali West, Mumbai",

                            // project.location.isEmpty
                            //     ? "No Location"
                            //     : project.location,
                            project.location,
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Starting from",
                                style: TextStyle(
                                  color: AppColors.textGrey,
                                  fontSize: 9,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.currency_rupee_sharp,
                                    color: AppColors.primaryDark,
                                    size: 12,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    // "₹2.45 Cr",
                                    //  project.price.isEmpty
                                    //     ? "Price On Request"
                                    //     : "₹${project.price}",
                                    project.price,

                                    style: TextStyle(
                                      color: AppColors.primaryDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryDark,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              minimumSize: const Size(0, 28),
                            ),
                            child: const Text(
                              "View",
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// ================= QUICK ACTION =================
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
        return GestureDetector(
          onTap: () {
            final label = actions[index]["label"];

            switch (label) {
              case "Add Customer":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCustomer(title: ''),
                  ),
                );
                break;

              case "Sales History":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SalesHistory()),
                );
                break;

              case "My Customers":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Customer()),
                );
                break;

              case "Create Associate":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateAssociateScreen(),
                  ),
                );
                break;

              case "Creatives":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreativesScreen(),
                  ),
                );
                break;

             case "Share App Link":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ShareScreen(title: "Share App & Earn"),
                  ),
                );
                break;
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: QuickActionColors.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: QuickActionColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ===== ICON CIRCLE =====
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: const Color(0xFFF4EDE0),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    actions[index]["icon"] as IconData,
                    color: QuickActionColors.iconColor,
                    size: 22,
                  ),
                ),

                const SizedBox(height: 12),

                // ===== TEXT =====
                Text(
                  actions[index]["label"] as String,
                  style: const TextStyle(
                    color: QuickActionColors.text,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class QuickActionColors {
  static const Color cardBg = Color(0xFFF9FAFB); // Soft white/grey
  static const Color border = Color(0xFFE5E7EB); // Light border
  static const Color iconBg = Color(0xFFF3F4F6); // Circle bg
  static const Color iconColor = Color(0xFF1E3A8A); // Dark blue
  static const Color text = Color(0xFF111827); // Title color
}

/// ================= OFFERS =================
class SpecialOffersSection extends StatelessWidget {
  const SpecialOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ================= CARD 1 =================
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: OfferColors.goldBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: OfferColors.goldBorder),
          ),
          child: Stack(
            children: [
              // STAR ICON (TOP RIGHT)
              Positioned(
                right: -10,
                top: -10,
                child: Icon(
                  Icons.star,
                  size: 80,
                  color: OfferColors.goldBadge.withOpacity(0.15),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // BADGE
                  Row(
                    children: [
                      const Icon(
                        Icons.card_giftcard,
                        size: 18,
                        color: OfferColors.goldBadge,
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: OfferColors.goldBadge,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "LIMITED TIME",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // TITLE
                  const Text(
                    "Festive Season Offer",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: OfferColors.title,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // DESC
                  const Text(
                    "Get up to ₹2 Lakhs off on bookings\nthis month",
                    style: TextStyle(fontSize: 13, color: OfferColors.desc),
                  ),

                  const SizedBox(height: 14),

                  // CTA
                  const Text(
                    "View Details →",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: OfferColors.goldBadge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ================= CARD 2 =================
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: OfferColors.blueBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: OfferColors.blueBorder),
          ),
          child: Stack(
            children: [
              // TREND ICON
              Positioned(
                right: 0,
                top: 10,
                child: Icon(
                  Icons.trending_up,
                  size: 40,
                  color: OfferColors.blueBadge.withOpacity(0.2),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // BADGE
                  Row(
                    children: [
                      const Icon(
                        Icons.flash_on,
                        size: 18,
                        color: OfferColors.blueBadge,
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: OfferColors.blueBadge,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "FLASH DEAL",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // TITLE
                  const Text(
                    "Zero Down Payment",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: OfferColors.title,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // DESC
                  const Text(
                    "Book your dream home with zero\n"
                    "down payment",
                    style: TextStyle(fontSize: 13, color: OfferColors.desc),
                  ),

                  const SizedBox(height: 14),

                  // CTA
                  const Text(
                    "Learn More →",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: OfferColors.blueBadge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OfferColors {
  // CARD 1 (Gold Theme)
  static const Color goldBg = Color(0xFFF5F1E6);
  static const Color goldBorder = Color(0xFFE5D3A3);
  static const Color goldBadge = Color(0xFFC49A50);

  // CARD 2 (Blue Theme)
  static const Color blueBg = Color(0xFFEFF2F8);
  static const Color blueBorder = Color(0xFFCBD5E1);
  static const Color blueBadge = Color(0xFF0B1F5B);

  // COMMON
  static const Color title = Color(0xFF0F172A);
  static const Color desc = Color(0xFF64748B);
}

/// ================= ACTIVITY =================
class RecentActivityList extends StatelessWidget {
  const RecentActivityList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        "icon": Icons.person,
        "iconColor": const Color(0xFF6D28D9),
        "title": "New Lead Added",
        "desc": "Amit Sharma - GJKedia Signature Towers",
        "time": "2 hours ago",
      },
      {
        "icon": Icons.location_on,
        "iconColor": const Color(0xFFE11D48),
        "title": "Site Visit Completed",
        "desc": "Priya Patel visited Prime Residency",
        "time": "5 hours ago",
      },
      {
        "icon": Icons.attach_money,
        "iconColor": const Color(0xFFF59E0B),
        "title": "Sale Closed",
        "desc": "₹2.45 Cr - Signature Towers (3 BHK)",
        "time": "1 day ago",
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final activity = activities[index];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ActivityColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== ICON =====
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (activity["iconColor"] as Color).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  activity["icon"] as IconData,
                  color: activity["iconColor"] as Color,
                  size: 20,
                ),
              ),

              const SizedBox(width: 14),

              // ===== TEXT CONTENT =====
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      activity["title"] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ActivityColors.title,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // DESCRIPTION
                    Text(
                      activity["desc"] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        color: ActivityColors.desc,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // TIME
                    Text(
                      activity["time"] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ActivityColors.time,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ActivityColors {
  static const Color cardBg = Color(0xFFF8FAFC);
  static const Color border = Color(0xFFE2E8F0);
  static const Color title = Color(0xFF0F172A);
  static const Color desc = Color(0xFF64748B);
  static const Color time = Color(0xFF94A3B8);
}
