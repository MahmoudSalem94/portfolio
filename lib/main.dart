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
  final GlobalKey _achievementsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _allProjectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();

  // Contact Information
  final String cvUrl = 'https://drive.google.com/file/d/1hMBrd2a1YKdn5Dc0TY7Ehg8fZBiH6emy/view?usp=drive_link';
  final String phoneNumber = '+971555152207';
  final String email = 'mahmoud.salem94@outlook.com';
// Add this key at the top of your _MyHomePageState class
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Project filter state
  String _selectedCategory = 'All';

// ... inside your _MyHomePageState class ...


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
// Add this method inside your _MyHomePageState class
  Widget _drawerNavButton(String text, VoidCallback onPressed) {
    return ListTile(
      title: Text(
        text,
        textAlign: TextAlign.center,      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      ),
      onTap: () {
        // Close the drawer first
        Navigator.of(context).pop();
        // Then execute the scroll action
        onPressed();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1A1A2E),
      // Define the drawer that opens from the right
      endDrawer: Drawer(
        backgroundColor: const Color(0xFF1A1A2E).withOpacity(0.95),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          children: [
            _drawerNavButton('Home', () => _scrollToSection(_homeKey)),
            _drawerNavButton('About', () => _scrollToSection(_aboutKey)),
            _drawerNavButton('Skills', () => _scrollToSection(_skillsKey)),
            _drawerNavButton('Projects', () => _scrollToSection(_projectsKey)),
          ],
        ),
      ),
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

                // Achievements Section
                _buildAchievementsSection(key: _achievementsKey),

                // Skills Section
                _buildSkillsSection(key: _skillsKey),

                // Projects Section
                _buildProjectsSection(key: _projectsKey),

                // All Projects Section
                _buildAllProjectsSection(key: _allProjectsKey),

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
                      _scaffoldKey.currentState?.openEndDrawer();
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
      padding: const EdgeInsets.only(left: 50, right: 50, top: 100,bottom:100), // Added top padding to avoid navbar
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
                  'MAHMOUD SALEM IBRAHIM',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 52,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 15),

                // Title with gradient
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  ).createShader(bounds),
                  child: Text(
                    'Flutter Developer | 5+ Years Experience | 15+ Apps Published',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFF667EEA), size: 20),
                    const SizedBox(width: 5),
                    Text(
                      'Based in Dubai, UAE',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Tagline/Subtitle
                SizedBox(
                  width: isMobile ? double.infinity : 700,
                  child: Text(
                    'Specialized in Fintech, E-commerce & Enterprise Mobile Solutions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: isMobile ? double.infinity : 700,
                  child: Text(
                    'Expert in Payment Integrations, Security Implementations & Real-time Features',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 18,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Quick Stats Cards
                _buildQuickStats(isMobile),
                const SizedBox(height: 40),

                // CTA Buttons
                // Responsive CTA Buttons
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Use a breakpoint to decide the layout.
                    // e.g., 420 pixels is a good breakpoint for these two buttons.
                    bool isWide = constraints.maxWidth > 420;

                    return Flex(
                      direction: isWide ? Axis.horizontal : Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // This ensures the column takes only the needed height
                      mainAxisSize: MainAxisSize.min,
                      // This centers the items when in a column
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _gradientButton(
                          'View Projects',
                              () => _scrollToSection(_projectsKey),
                        ),
                        // Use SizedBox with height for column, width for row
                        isWide
                            ? const SizedBox(width: 20)
                            : const SizedBox(height: 20),
                        _outlineButton(
                          'Download CV',
                              () => _openUrl(cvUrl),
                        ),
                      ],
                    );
                  },
                ),

              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuickStats(bool isMobile) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 1000),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          _statCard('15+', 'Apps Published', Icons.apps, isMobile),
          _statCard('100K+', 'Users Reached', Icons.people, isMobile),
          _statCard('3+', 'Fintech Apps', Icons.account_balance, isMobile),
          _statCard('Security-First', 'Approach', Icons.security, isMobile),
          _statCard('Real-time', 'Systems Expert', Icons.speed, isMobile),
          _statCard('UAE Market', 'Specialist', Icons.public, isMobile),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label, IconData icon, bool isMobile) {
    return Container(
      width: isMobile ? (MediaQuery.of(context).size.width - 100) / 2 : 150,
      height: 130, // Fixed height for uniform cards
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF667EEA).withOpacity(0.2),
            const Color(0xFF764BA2).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF667EEA).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF667EEA), size: 32),
          const SizedBox(height: 10),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white70,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
          'Professional Summary',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'I\'m a Flutter Developer with over 5 years of experience building scalable, secure mobile applications for fintech, e-commerce, and enterprise clients across the UAE. I specialize in creating high-performance apps with complex payment integrations, real-time features, and banking-grade security.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Currently working at DSCALE.io, I\'ve contributed to major UAE projects including Ayshei (UAE\'s first web3 marketplace), xfi (money transfer app by Index Exchange), and Dalma Mall App (Abu Dhabi\'s largest mall companion app).',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'What I Do Best',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        _expertiseItem(
          Icons.account_balance,
          'FINTECH SOLUTIONS',
          'Building secure payment systems, money transfer apps, and banking integrations compliant with UAE regulations',
        ),
        const SizedBox(height: 15),
        _expertiseItem(
          Icons.business,
          'ENTERPRISE APPS',
          'Developing large-scale applications for UAE businesses with features like indoor navigation and real-time tracking',
        ),
        const SizedBox(height: 15),
        _expertiseItem(
          Icons.shopping_cart,
          'E-COMMERCE & MARKETPLACES',
          'Creating auction systems, classified ads platforms, and shopping apps with advanced payment processing',
        ),
        const SizedBox(height: 15),
        _expertiseItem(
          Icons.security,
          'SECURITY & COMPLIANCE',
          'Implementing banking-grade security with freeRASP, biometric authentication, and Emirates ID KYC verification',
        ),
      ],
    );
  }

  Widget _expertiseItem(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF667EEA),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                  height: 1.5,
                ),
              ),
            ],
          ),
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
          _statItem('15+', 'Production Apps'),
          const SizedBox(height: 30),
          _statItem('100K+', 'Active Users'),
          const SizedBox(height: 30),
          _statItem('99.9%', 'Crash-Free Rate'),
          const SizedBox(height: 30),
          _statItem('Zero', 'Security Breaches'),
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

  Widget _buildAchievementsSection({required GlobalKey key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0A0E27),
            const Color(0xFF1A1F3A).withOpacity(0.5),
          ],
        ),
      ),
      child: Column(
        children: [
          _sectionTitle('Impact & Achievements'),
          const SizedBox(height: 20),
          const Text(
            'Results that speak for themselves',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 60),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 768;

              if (isMobile) {
                return Column(
                  children: [
                    _achievementCard(
                      Icons.apps,
                      '15+',
                      'Production Apps',
                      'Successfully published and maintained across App Store and Google Play',
                    ),
                    const SizedBox(height: 20),
                    _achievementCard(
                      Icons.people,
                      '100,000+',
                      'Active Users',
                      'Apps collectively serving users across UAE, Saudi Arabia, Egypt, and Qatar',
                    ),
                    const SizedBox(height: 20),
                    _achievementCard(
                      Icons.account_balance,
                      'Fintech Expertise',
                      '3 Major Apps',
                      'Built fintech applications handling sensitive financial transactions with zero security breaches',
                    ),
                    const SizedBox(height: 20),
                    _achievementCard(
                      Icons.bug_report,
                      '99.9%',
                      'Crash-Free Rate',
                      'Maintained across all production apps through comprehensive testing and monitoring',
                    ),
                    const SizedBox(height: 20),
                    _achievementCard(
                      Icons.speed,
                      '40%',
                      'Performance Boost',
                      'Reduced API response times through implementation of efficient caching strategies',
                    ),
                    const SizedBox(height: 20),
                    _achievementCard(
                      Icons.security,
                      'Security First',
                      'Zero Breaches',
                      'Integrated freeRASP SDK protecting apps from tampering and reverse engineering',
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _achievementCard(
                          Icons.apps,
                          '15+',
                          'Production Apps',
                          'Successfully published and maintained across App Store and Google Play',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _achievementCard(
                          Icons.people,
                          '100,000+',
                          'Active Users',
                          'Apps collectively serving users across UAE, Saudi Arabia, Egypt, and Qatar',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _achievementCard(
                          Icons.account_balance,
                          'Fintech Expertise',
                          '3 Major Apps',
                          'Built fintech applications handling sensitive financial transactions with zero security breaches',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _achievementCard(
                          Icons.bug_report,
                          '99.9%',
                          'Crash-Free Rate',
                          'Maintained across all production apps through comprehensive testing and monitoring',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _achievementCard(
                          Icons.speed,
                          '40%',
                          'Performance Boost',
                          'Reduced API response times through implementation of efficient caching strategies',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _achievementCard(
                          Icons.security,
                          'Security First',
                          'Zero Breaches',
                          'Integrated freeRASP SDK protecting apps from tampering and reverse engineering',
                        ),
                      ),
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

  Widget _achievementCard(IconData icon, String value, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF667EEA).withOpacity(0.15),
            const Color(0xFF764BA2).withOpacity(0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF667EEA).withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
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
            child: Icon(icon, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 20),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF667EEA),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white60,
              height: 1.5,
            ),
          ),
        ],
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

              return Wrap(
                spacing: isMobile ? 0 : 30,
                runSpacing: 20,
                children: [
                  // Core Development
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Flutter & Dart (5+ Years)', 95, Icons.flutter_dash),
                  ),
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Clean Architecture & MVVM', 90, Icons.architecture),
                  ),

                  // Backend & APIs
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('REST API & Dio/Retrofit', 92, Icons.api),
                  ),
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Firebase Ecosystem', 90, Icons.local_fire_department),
                  ),

                  // State Management
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Bloc/Cubit Pattern', 95, Icons.account_tree),
                  ),
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Provider & GetX', 88, Icons.settings_input_component),
                  ),

                  // Payments & Fintech
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Checkout.com & Stripe Integration', 90, Icons.payment),
                  ),
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Open Banking (Lean Technologies)', 85, Icons.account_balance),
                  ),

                  // Security
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('freeRASP & Security Implementation', 92, Icons.security),
                  ),
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Biometric Auth & Encryption', 88, Icons.fingerprint),
                  ),

                  // Real-time Features
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('WebRTC & Real-time Systems', 85, Icons.video_call),
                  ),
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('WebSocket & Socket.io', 82, Icons.sync_alt),
                  ),

                  // Maps & Navigation
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Google Maps & Indoor Navigation', 88, Icons.location_on),
                  ),
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Location Services & Geofencing', 85, Icons.my_location),
                  ),

                  // Platform & Tools
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('iOS & Android Native Integration', 87, Icons.devices),
                  ),
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Git & CI/CD', 90, Icons.source),
                  ),

                  // UI/UX
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Material Design & Cupertino', 92, Icons.design_services),
                  ),
                  SizedBox(
                    width: isMobile ? double.infinity : (constraints.maxWidth - 30) / 2,
                    child: _skillProgressBar('Responsive UI & Animations', 90, Icons.web),
                  ),
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
          // Only show store section if at least one valid URL exists
          if ((appStoreUrl != null && appStoreUrl.isNotEmpty) ||
              (playStoreUrl != null && playStoreUrl.isNotEmpty)) ...[
            const SizedBox(height: 25),
            const Divider(color: Colors.white10, thickness: 1),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                // Decide on a breakpoint. 400 is a reasonable value for this context.
                bool isWide = constraints.maxWidth > 400;

                return Flex(
                  // Use Row for wide screens, Column for narrow screens
                  direction: isWide ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: isWide ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Important to prevent Flex from expanding
                  children: [
                    const Text(
                      'Available on:',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Add spacing conditionally
                    isWide
                        ? const SizedBox(width: 15)
                        : const SizedBox(height: 15),
                    if (appStoreUrl != null && appStoreUrl.isNotEmpty)
                      _storeButton('App Store', Icons.apple, () => _openUrl(appStoreUrl)),
                    if ((appStoreUrl != null && appStoreUrl.isNotEmpty) &&
                        (playStoreUrl != null && playStoreUrl.isNotEmpty))
                      isWide
                          ? const SizedBox(width: 10)
                          : const SizedBox(height: 10),
                    if (playStoreUrl != null && playStoreUrl.isNotEmpty)
                      _storeButton('Play Store', Icons.android, () => _openUrl(playStoreUrl)),
                  ],
                );
              },
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

  Widget _buildAllProjectsSection({required GlobalKey key}) {
    final categories = ['All', 'Fintech', 'E-commerce', 'Enterprise', 'Healthcare', 'Delivery'];

    // Define all projects with categories
    final allProjects = [
      {'name': 'Mo3amalat', 'category': 'Enterprise', 'icon': Icons.video_call, 'company': 'It.Com', 'appStore': null, 'playStore': null, 'description': 'Government services platform with live video chat connecting customers with agents for document preparation'},
      {'name': 'Mnzlak', 'category': 'E-commerce', 'icon': Icons.home, 'company': 'It.Com', 'appStore': null, 'playStore': null, 'description': 'Real estate marketplace for renting or buying apartments in UAE'},
      {'name': 'My Order', 'category': 'Delivery', 'icon': Icons.restaurant, 'company': 'It.Com', 'appStore': null, 'playStore': null, 'description': 'Multi-restaurant food delivery with real-time order tracking'},
      {'name': 'MyKom', 'category': 'Delivery', 'icon': Icons.water_drop, 'company': 'Technology District', 'appStore': 'https://apps.apple.com/us/app/mykom/id1638383150', 'playStore': 'https://play.google.com/store/apps/details?id=com.districtapp.mykomapp', 'description': 'Water delivery platform connecting users to service providers'},
      {'name': 'Cerameco', 'category': 'Healthcare', 'icon': Icons.health_and_safety, 'company': 'Ragueh SCG', 'appStore': null, 'playStore': null, 'description': 'Dental clinic app for appointments and online diagnoses'},
      {'name': 'Smiletech', 'category': 'Healthcare', 'icon': Icons.medical_services, 'company': 'Ragueh SCG', 'appStore': null, 'playStore': null, 'description': 'Communication platform between dental lab and dentist clients'},
      {'name': 'Elbayrak', 'category': 'Enterprise', 'icon': Icons.pets, 'company': 'Freelance', 'appStore': null, 'playStore': null, 'description': 'Livestock management system for tracking animals, vaccinations, and sales'},
      {'name': 'Zabayh', 'category': 'E-commerce', 'icon': Icons.shopping_basket, 'company': 'Freelance', 'appStore': 'https://apps.apple.com/eg/app/id1589950806', 'playStore': 'https://play.google.com/store/apps/details?id=com.qrc.zabayh', 'description': 'Butcher marketplace with variety of meat products'},
    ];

    final filteredProjects = _selectedCategory == 'All'
        ? allProjects
        : allProjects.where((p) => p['category'] == _selectedCategory).toList();

    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1A1F3A).withOpacity(0.5),
            const Color(0xFF0A0E27),
          ],
        ),
      ),
      child: Column(
        children: [
          _sectionTitle('All Projects'),
          const SizedBox(height: 20),
          const Text(
            'Complete portfolio of 11+ published applications',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 40),

          // Category Filters
          Wrap(
            spacing: 15,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: categories.map((category) {
              final isSelected = _selectedCategory == category;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                          )
                        : null,
                    color: isSelected ? null : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF667EEA)
                          : Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 60),

          // Projects Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 768;
              final crossAxisCount = isMobile ? 1 : 2;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio: isMobile ? 1.2 : 2.0, // Much shorter cards
                ),
                itemCount: filteredProjects.length,
                itemBuilder: (context, index) {
                  final project = filteredProjects[index];
                  return _compactProjectCard(
                    project['name'] as String,
                    project['description'] as String,
                    project['company'] as String,
                    project['category'] as String,
                    project['icon'] as IconData,
                    project['appStore'] as String?,
                    project['playStore'] as String?,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _compactProjectCard(
    String name,
    String description,
    String company,
    String category,
    IconData icon,
    String? appStore,
    String? playStore,
  ) {
    return Container(
      padding: const EdgeInsets.all(16), // Reduced from 20
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF667EEA).withOpacity(0.1),
            const Color(0xFF764BA2).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16), // Reduced from 20
        border: Border.all(
          color: const Color(0xFF667EEA).withOpacity(0.3),
          width: 1.5, // Reduced from 2
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8), // Reduced from 10
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 20), // Reduced from 24
              ),
              const SizedBox(width: 10), // Reduced from 12
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16, // Reduced from 18
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      company,
                      style: const TextStyle(
                        fontSize: 10, // Reduced from 11
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8), // Reduced from 12
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), // Reduced padding
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category,
              style: const TextStyle(
                fontSize: 9, // Reduced from 10
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8), // Reduced from 10
          Text(
            description,
            style: const TextStyle(
              fontSize: 12, // Reduced from 13
              color: Colors.white70,
              height: 1.3, // Reduced from 1.4
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          // Only show store buttons if at least one valid URL exists
          if ((appStore != null && appStore.isNotEmpty) ||
              (playStore != null && playStore.isNotEmpty)) ...[
            const SizedBox(height: 8), // Reduced from 12
            Row(
              children: [
                if (appStore != null && appStore.isNotEmpty)
                  Expanded(
                    child: _smallStoreButton('App Store', Icons.apple, () => _openUrl(appStore)),
                  ),
                if ((appStore != null && appStore.isNotEmpty) &&
                    (playStore != null && playStore.isNotEmpty))
                  const SizedBox(width: 6), // Reduced from 8
                if (playStore != null && playStore.isNotEmpty)
                  Expanded(
                    child: _smallStoreButton('Play Store', Icons.android, () => _openUrl(playStore)),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _smallStoreButton(String label, IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4), // Reduced vertical padding
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF667EEA).withOpacity(0.2),
              const Color(0xFF764BA2).withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(6), // Reduced from 8
          border: Border.all(
            color: const Color(0xFF667EEA).withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white70, size: 12), // Reduced from 14
            const SizedBox(width: 4), // Reduced from 5
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10, // Reduced from 11
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
                'Let\'s Work Together',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'I\'m always interested in hearing about new projects and opportunities',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),

              // Contact Details
              Wrap(
                spacing: 40,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _contactInfoItem(Icons.phone, phoneNumber, 'tel:$phoneNumber'),
                  _contactInfoItem(Icons.email, email, 'mailto:$email'),
                  _contactInfoItem(Icons.location_on, 'Dubai, UAE', null),
                ],
              ),

              const SizedBox(height: 50),

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
                '© 2025 Mahmoud Salem Ibrahim. All rights reserved.',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Built with Flutter | Dubai, UAE',
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

  Widget _contactInfoItem(IconData icon, String text, String? url) {
    return InkWell(
      onTap: url != null ? () => _openUrl(url) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF667EEA).withOpacity(0.2),
              const Color(0xFF764BA2).withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF667EEA), size: 20),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
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
