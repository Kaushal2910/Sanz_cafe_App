import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../user/menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _scale = Tween<double>(
      begin: 0.94,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack));

    // separate controller for button pulse
    _pulse = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    // start the animation; button will continuously pulse by repeating controller
    _ctrl.forward();
    _ctrl.addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        _ctrl.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _buildHero(BuildContext c) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sanz Café",
              style: TextStyle(
                color: AppTheme.gold,
                fontSize: 38,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                fontFamily: "Poppins",
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Fresh • Fast • Delicious",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTA(BuildContext ctx) {
    return ScaleTransition(
      scale: _pulse,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            ctx,
            MaterialPageRoute(builder: (_) => const MenuPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.gold,
          foregroundColor: AppTheme.black,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 8,
          shadowColor: AppTheme.gold.withOpacity(0.3),
        ),
        child: const Text(
          "Order Now",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(String title, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.gold.withOpacity(0.08)),
          ),
          child: Icon(icon, color: AppTheme.gold, size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontFamily: "Poppins",
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isTall = mq.size.height > 700;
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            children: [
              // top AppBar area (title left, cart icon right optional)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sanz Café",
                    style: TextStyle(
                      color: AppTheme.gold,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // placeholder for cart/profile (can be replaced later)
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pushNamed(context, '/cart'),
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/admin-login'),
                        icon: const Icon(
                          Icons.admin_panel_settings,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // HERO container with gradient
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF000000), Color(0xFFFFD700)],
                    stops: [0.0, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // animated hero
                    _buildHero(context),
                    const SizedBox(height: 18),
                    // CTA
                    _buildCTA(context),
                    const SizedBox(height: 18),
                    // features row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFeature("Fresh", Icons.local_cafe),
                        _buildFeature("Fast", Icons.delivery_dining),
                        _buildFeature("Tasty", Icons.emoji_food_beverage),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // small tagline / info
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Explore our menu",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // category preview (horizontal chips) - non-interactive here, navigates to menu with same screen by tapping Order Now
              SizedBox(
                height: 52,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SizedBox(width: 6),
                    _CategoryPreview(title: "Pizza"),
                    SizedBox(width: 10),
                    _CategoryPreview(title: "Burgers"),
                    SizedBox(width: 10),
                    _CategoryPreview(title: "Sandwich"),
                    SizedBox(width: 10),
                    _CategoryPreview(title: "Pasta"),
                    SizedBox(width: 10),
                    _CategoryPreview(title: "Fries"),
                    SizedBox(width: 10),
                    _CategoryPreview(title: "Combos"),
                    SizedBox(width: 10),
                    _CategoryPreview(title: "Garlic Bread"),
                    SizedBox(width: 10),
                    _CategoryPreview(title: "Soup & Salad"),
                    SizedBox(width: 10),
                    _CategoryPreview(title: "Desserts"),
                    SizedBox(width: 10),
                    _CategoryPreview(title: "Drinks"),
                    SizedBox(width: 6),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // bottom small CTA / footer
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Open: 8:00 AM - 10:00 PM   •   Pickup & Dine-in available",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(height: isTall ? 40 : 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryPreview extends StatelessWidget {
  final String title;
  const _CategoryPreview({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.gold.withOpacity(0.12)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}
