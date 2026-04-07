import 'package:flutter/material.dart';
import 'package:gjk_cp/view/cp_details.dart';
import 'package:gjk_cp/view/cp_login_screen.dart';
import 'package:gjk_cp/view/login_screen.dart';

class AppColors {
  static const Color background = Color(0xFFF7F9FC);
  static const Color primaryDark = Color(0xFF00155B); // Navy Blue for Logo/Text
  static const Color accentGold = Color(0xFFC49A50); // Gold for accents
  static const Color textGrey = Color(0xFF6C757D);
  static const Color lightGrey = Color(0xFFE9ECEF);
  static const Color white = Colors.white;
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.title});
  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // 1. This variable tracks which bottom tab is currently selected
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // 2. This is the list of your "Fragments" (Screens)
  // Index 0 is the massive UI we built earlier. The rest are placeholders.
  final List<Widget> _pages = [
    const HomeContent(), // Index 0: Home
    const CpLoginScreen(),
    const CpDetails(title: "CP Details"),
    // const EnquiryScreen(),  // Index 1
    const PlaceholderScreen(title: "Enquiry"), // Index 2
    const PlaceholderScreen(title: "Call Us"), // Index 3
    const PlaceholderScreen(title: "Video"), // Index 4
  ];

  // 3. This function changes the active tab and rebuilds the UI
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,

      // ==========================================
      // TOP BAR (APP BAR)
      // ==========================================
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0, // Removes shadow
        centerTitle: true,
        // Hamburger Menu Icon
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87, size: 28),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        // Center Logo Area
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'GJKedia',
              style: TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'HOMES',
              style: TextStyle(
                color: AppColors.accentGold,
                fontSize: 10,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        // Notification Bell Area
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.black87,
                    size: 28,
                  ),
                  onPressed: () {},
                ),
                // The little gold notification dot
                Positioned(
                  top: 12,
                  right: 10,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.accentGold,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.75,
        backgroundColor: DrawerColors.bg,
        child: SafeArea(
          child: Column(
            children: [
              // ===== TOP SECTION =====
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ===== PROFILE =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: DrawerColors.avatarGold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Rajesh Kumar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "+91 98765 43210",
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== DIVIDER =====
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                color: DrawerColors.divider,
              ),

              const SizedBox(height: 20),

              // ===== MENU ITEMS =====
              drawerItem(
                Icons.home_outlined,
                "Home",
                onTap: () {
                  Navigator.pop(context); // close drawer
                  setState(() {
                    _selectedIndex = 0; // ✅ switch to Home
                  });
                },
              ),
              drawerItem(
                Icons.person_outline,
                "CP Details",
                onTap: () {
                  Navigator.pop(context); // close drawer

                  setState(() {
                    _selectedIndex = 2; // ✅ switch to CP Details screen
                  });
                },
              ),
              drawerItem(Icons.call_outlined, "Tele Caller", onTap: () {}),
              drawerItem(
                Icons.person_2_outlined,
                "Customer Login",
                onTap: () {},
              ),

              const Spacer(), // ✅ NOW CORRECT PLACE
              // ===== LOGOUT BUTTON =====
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    showLogoutDialog(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),

      // ==========================================
      // BODY (THE FRAGMENT THAT SWAPS)
      // ==========================================
      body: _pages[_selectedIndex],

      // ==========================================
      // BOTTOM NAVIGATION BAR
      // ==========================================
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Required when > 3 items
          backgroundColor: AppColors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.accentGold,
          unselectedItemColor: AppColors.textGrey,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.home_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.home),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.person_outline),
              ),
              label: 'CP Login',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.description_outlined),
              ),
              label: 'Enquiry',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.phone_outlined),
              ),
              label: 'Call Us',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.videocam_outlined),
              ),
              label: 'Video',
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(
    IconData icon,
    String title, {
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(title: "Login"),
                  ),
                  (route) => false,
                );
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}

class DrawerColors {
  static const Color bg = Color(0xFF0A1F66); // Deep Navy Blue
  static const Color white = Colors.white;
  static const Color divider = Color(0xFF1E3A8A); // Soft divider blue
  static const Color avatarGold = Color(0xFFC9A24A); // Gold circle
}

// ============================================================================
// PLACEHOLDER SCREEN FOR OTHER TABS
// ============================================================================
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "$title Screen\n(Under Construction)",
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.textGrey, fontSize: 18),
      ),
    );
  }
}

// ============================================================================
// HOME CONTENT (The original UI built previously)
// ============================================================================
class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// --- BELOW ARE THE REUSABLE WIDGETS FROM THE FIRST STEP ---

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
          image: NetworkImage(
            'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?q=80&w=1000&auto=format&fit=crop',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "GJKedia Signature Towers",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white70,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  "Kandivali West, Mumbai",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
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
                  children: const [
                    Text(
                      "Starting from",
                      style: TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                    Text(
                      "₹2.45 Cr",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
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
  const SectionHeader({
    Key? key,
    required this.title,
    required this.showViewAll,
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
          Text(
            "View All",
            style: TextStyle(
              color: AppColors.accentGold.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
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
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
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
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
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
                        children: const [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.textGrey,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Kandivali West, Mumbai",
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
                            children: const [
                              Text(
                                "Starting from",
                                style: TextStyle(
                                  color: AppColors.textGrey,
                                  fontSize: 9,
                                ),
                              ),
                              Text(
                                "₹2.45 Cr",
                                style: TextStyle(
                                  color: AppColors.primaryDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
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
