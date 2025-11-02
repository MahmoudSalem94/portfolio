import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0E27),
        fontFamily: 'Poppins',
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({Key? key}) : super(key: key);

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();

  // Contact Information
  final String cvUrl = 'https://drive.google.com/file/d/1hMBrd2a1YKdn5Dc0TY7Ehg8fZBiH6emy/view?usp=drive_link';
  final String phoneNumber = '+971555152207';
  final String email = 'mahmoud.salem94@outlook.com';

  // Open URL method
  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Show error if URL cannot be opened
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open link')),
        );
      }
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF0A0E27),
                  const Color(0xFF1A1F3A),
                  const Color(0xFF0A0E27),
                ],
              ),
            ),
          ),

          // Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                _buildHeroSection(key: _homeKey),

                // About Section
                _buildAboutSection(key: _aboutKey),

                // Skills Section
                _buildSkillsSection(key: _skillsKey),

                // Projects Section
                _buildProjectsSection(key: _projectsKey),

                // Footer
                _buildFooter(),
              ],
            ),
          ),

          // Navigation Bar
          _buildNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0E27).withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 768;

            if (isMobile) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Portfolio',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      // Add mobile menu functionality
                    },
                  ),
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Portfolio',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    _navButton('Home', () => _scrollToSection(_homeKey)),
                    _navButton('About', () => _scrollToSection(_aboutKey)),
                    _navButton('Skills', () => _scrollToSection(_skillsKey)),
                    _navButton('Projects', () => _scrollToSection(_projectsKey)),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _navButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildHeroSection({required GlobalKey key}) {
    return Container(
      key: key,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 768;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Image
                Container(
                  width: isMobile ? 150 : 200,
                  height: isMobile ? 150 : 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4,
                      color: const Color(0xFF667EEA),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF667EEA).withOpacity(0.5),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/A37180.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback if image fails to load
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 100,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Name
                Text(
                  'Mahmoud Salem Ibrahim',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 36 : 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),

                // Title with gradient
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  ).createShader(bounds),
                  child: Text(
                    'Flutter Developer & Designer',
                    style: TextStyle(
                      fontSize: isMobile ? 20 : 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Description
                SizedBox(
                  width: isMobile ? double.infinity : 600,
                  child: Text(
                    'Passionate about creating beautiful and functional mobile & web applications',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // CTA Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _gradientButton(
                      'View Projects',
                      () => _scrollToSection(_projectsKey),
                    ),
                    const SizedBox(width: 20),
                    _outlineButton(
                      'Download CV',
                      () => _openUrl(cvUrl),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAboutSection({required GlobalKey key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return Column(
            children: [
              _sectionTitle('About Me'),
              const SizedBox(height: 60),

              if (isMobile)
                Column(
                  children: [
                    _aboutContent(),
                    const SizedBox(height: 40),
                    _aboutStats(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _aboutContent()),
                    const SizedBox(width: 60),
                    Expanded(child: _aboutStats()),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _aboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hello! I\'m a passionate Flutter developer with expertise in building beautiful, responsive applications for mobile and web platforms.',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'I love turning ideas into reality through clean code and intuitive design. My focus is on creating user-centric applications that not only look great but also provide seamless user experiences.',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            _interestChip('Mobile Development'),
            _interestChip('Web Development'),
            _interestChip('UI/UX Design'),
            _interestChip('Open Source'),
          ],
        ),
      ],
    );
  }

  Widget _aboutStats() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF667EEA).withOpacity(0.1),
            const Color(0xFF764BA2).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF667EEA).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _statItem('5+', 'Years Experience'),
          const SizedBox(height: 30),
          _statItem('50+', 'Projects Completed'),
          const SizedBox(height: 30),
          _statItem('30+', 'Happy Clients'),
          const SizedBox(height: 30),
          _statItem('100%', 'Satisfaction'),
        ],
      ),
    );
  }

  Widget _statItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _interestChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSkillsSection({required GlobalKey key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Column(
        children: [
          _sectionTitle('Skills & Expertise'),
          const SizedBox(height: 20),
          const Text(
            'Technologies and tools I work with',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 60),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 768;

              return Column(
                children: [
                  _skillProgressBar('Flutter & Dart', 95, Icons.flutter_dash),
                  const SizedBox(height: 25),
                  _skillProgressBar('Firebase', 90, Icons.local_fire_department),
                  const SizedBox(height: 25),
                  _skillProgressBar('REST API Integration', 88, Icons.api),
                  const SizedBox(height: 25),
                  _skillProgressBar('Payment Gateway Integration', 85, Icons.payment),
                  const SizedBox(height: 25),
                  _skillProgressBar('State Management (Provider, Bloc)', 90, Icons.account_tree),
                  const SizedBox(height: 25),
                  _skillProgressBar('UI/UX Design', 85, Icons.design_services),
                  const SizedBox(height: 25),
                  _skillProgressBar('Git & Version Control', 88, Icons.source),
                  const SizedBox(height: 25),
                  _skillProgressBar('Google Maps & Location Services', 82, Icons.location_on),
                  const SizedBox(height: 25),
                  _skillProgressBar('Push Notifications', 85, Icons.notifications),
                  const SizedBox(height: 25),
                  _skillProgressBar('Responsive Design (iOS & Android)', 92, Icons.devices),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _skillProgressBar(String skillName, int percentage, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF667EEA).withOpacity(0.1),
            const Color(0xFF764BA2).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF667EEA).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  skillName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF667EEA),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage / 100,
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF667EEA).withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection({required GlobalKey key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Column(
        children: [
          _sectionTitle('Featured Projects'),
          const SizedBox(height: 60),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 768;

              if (isMobile) {
                return Column(
                  children: [
                    _projectCard(
                      'AYSHEI',
                      'Your all-in-one solution for classified ads, auctions, real estate, and vehicles with comprehensive business tools.',
                      ['Flutter', 'Payment Gateway', 'Real-time Bidding', 'Firebase'],
                      Icons.shopping_bag,
                      appStoreUrl: 'https://apps.apple.com/us/app/ayshei/id6445907409',
                      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.ayshei',
                      rating: '5.0',
                      downloads: '5K+',
                      features: [
                        'Multiple product categories including Properties, Motors, Electronics',
                        'Live auctions with real-time bidding capabilities',
                        'Virtual storefront with payment gateway integration',
                        'Comprehensive UAE property listings with market intelligence',
                      ],
                    ),
                    const SizedBox(height: 30),
                    _projectCard(
                      'xfi – Send Money Online',
                      'Secure, instant money transfers from UAE to 100+ countries with competitive exchange rates.',
                      ['Flutter', 'FinTech', 'Multi-level Encryption', 'REST API'],
                      Icons.account_balance,
                      appStoreUrl: 'https://apps.apple.com/us/app/xfi-send-money-online/id6449428867',
                      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.index.xfi.wallet',
                      rating: '4.5',
                      downloads: '2K+',
                      features: [
                        'Registered with Central Bank of UAE for secure transactions',
                        'Best exchange rates with low transfer fees',
                        'Multiple transfer options: bank, cash pickup, mobile wallet',
                        'Real-time transaction tracking with 24/7 customer support',
                      ],
                    ),
                    const SizedBox(height: 30),
                    _projectCard(
                      'Dalma Mall App',
                      'Complete shopping companion for Abu Dhabi\'s premier mall with 450+ international brands.',
                      ['Flutter', 'Indoor Navigation', 'Push Notifications', 'Google Maps'],
                      Icons.store,
                      appStoreUrl: 'https://apps.apple.com/ae/app/dalma-mall-app/id1609909953',
                      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.dscale.dalmaMallApp',
                      rating: '4.8',
                      downloads: '10K+',
                      features: [
                        'Advanced indoor wayfinding to locate stores instantly',
                        'Real-time events calendar with push notifications',
                        'Smart shopping list management per store',
                        'Exclusive offers and promotions from 450+ brands',
                      ],
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _projectCard(
                          'AYSHEI',
                          'Your all-in-one solution for classified ads, auctions, real estate, and vehicles with comprehensive business tools.',
                          ['Flutter', 'Payment Gateway', 'Real-time Bidding', 'Firebase'],
                          Icons.shopping_bag,
                          appStoreUrl: 'https://apps.apple.com/us/app/ayshei/id6445907409',
                          playStoreUrl: 'https://play.google.com/store/apps/details?id=com.ayshei',
                          rating: '5.0',
                          downloads: '5K+',
                          features: [
                            'Multiple product categories including Properties, Motors, Electronics',
                            'Live auctions with real-time bidding capabilities',
                            'Virtual storefront with payment gateway integration',
                            'Comprehensive UAE property listings with market intelligence',
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: _projectCard(
                          'xfi – Send Money Online',
                          'Secure, instant money transfers from UAE to 100+ countries with competitive exchange rates.',
                          ['Flutter', 'FinTech', 'Multi-level Encryption', 'REST API'],
                          Icons.account_balance,
                          appStoreUrl: 'https://apps.apple.com/us/app/xfi-send-money-online/id6449428867',
                          playStoreUrl: 'https://play.google.com/store/apps/details?id=com.index.xfi.wallet',
                          rating: '4.5',
                          downloads: '2K+',
                          features: [
                            'Registered with Central Bank of UAE for secure transactions',
                            'Best exchange rates with low transfer fees',
                            'Multiple transfer options: bank, cash pickup, mobile wallet',
                            'Real-time transaction tracking with 24/7 customer support',
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: _projectCard(
                          'Dalma Mall App',
                          'Complete shopping companion for Abu Dhabi\'s premier mall with 450+ international brands.',
                          ['Flutter', 'Indoor Navigation', 'Push Notifications', 'Google Maps'],
                          Icons.store,
                          appStoreUrl: 'https://apps.apple.com/ae/app/dalma-mall-app/id1609909953',
                          playStoreUrl: 'https://play.google.com/store/apps/details?id=com.dscale.dalmaMallApp',
                          rating: '4.8',
                          downloads: '10K+',
                          features: [
                            'Advanced indoor wayfinding to locate stores instantly',
                            'Real-time events calendar with push notifications',
                            'Smart shopping list management per store',
                            'Exclusive offers and promotions from 450+ brands',
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(child: Container()),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _projectCard(
    String title,
    String description,
    List<String> tech,
    IconData icon, {
    String? appStoreUrl,
    String? playStoreUrl,
    String? rating,
    String? downloads,
    List<String>? features,
  }) {
    return Container(
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF667EEA).withOpacity(0.15),
            const Color(0xFF764BA2).withOpacity(0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFF667EEA).withOpacity(0.4),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 35),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (rating != null || downloads != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            if (rating != null) ...[
                              const Icon(Icons.star, color: Color(0xFFFFD700), size: 18),
                              const SizedBox(width: 5),
                              Text(
                                rating,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                            if (rating != null && downloads != null)
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 12),
                                width: 1,
                                height: 12,
                                color: Colors.white30,
                              ),
                            if (downloads != null) ...[
                              const Icon(Icons.download, color: Colors.white60, size: 18),
                              const SizedBox(width: 5),
                              Text(
                                downloads,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.7,
            ),
          ),
          if (features != null && features.isNotEmpty) ...[
            const SizedBox(height: 20),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white60,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
          const SizedBox(height: 25),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: tech.map((t) => _techTag(t)).toList(),
          ),
          if (appStoreUrl != null || playStoreUrl != null) ...[
            const SizedBox(height: 25),
            const Divider(color: Colors.white10, thickness: 1),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Available on:',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 15),
                if (appStoreUrl != null)
                  _storeButton('App Store', Icons.apple, () => _openUrl(appStoreUrl)),
                if (appStoreUrl != null && playStoreUrl != null)
                  const SizedBox(width: 10),
                if (playStoreUrl != null)
                  _storeButton('Play Store', Icons.android, () => _openUrl(playStoreUrl)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _techTag(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF667EEA).withOpacity(0.3),
            const Color(0xFF764BA2).withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF667EEA).withOpacity(0.6),
          width: 1.5,
        ),
      ),
      child: Text(
        tech,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _storeButton(String label, IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF667EEA).withOpacity(0.2),
              const Color(0xFF764BA2).withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF667EEA).withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white70, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0A0E27),
            const Color(0xFF1A1F3A).withOpacity(0.5),
          ],
        ),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            width: 2,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return Column(
            children: [
              const Text(
                'Let\'s Connect',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Feel free to reach out for opportunities or just to say hello!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 40),

              // Action Buttons
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _actionButton(
                    'Download CV',
                    Icons.description,
                    () => _openUrl(cvUrl),
                    isMobile,
                  ),
                  _actionButton(
                    'Call Me',
                    Icons.phone,
                    () => _openUrl('tel:$phoneNumber'),
                    isMobile,
                  ),
                  _actionButton(
                    'Email Me',
                    Icons.email,
                    () => _openUrl('mailto:$email'),
                    isMobile,
                  ),
                ],
              ),

              const SizedBox(height: 50),
              const Divider(color: Colors.white10, thickness: 1),
              const SizedBox(height: 30),

              const Text(
                '© 2024 Mahmoud Salem Ibrahim. All rights reserved.',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Built with Flutter',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _actionButton(String label, IconData icon, VoidCallback onPressed, bool isMobile) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: isMobile ? double.infinity : 200,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667EEA).withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _gradientButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(String text, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        side: const BorderSide(color: Color(0xFF667EEA), width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}