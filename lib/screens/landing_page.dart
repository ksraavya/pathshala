import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:math';
import 'login/teacher_login.dart';
import 'login/student_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Interval(0.0, 0.4, curve: Curves.easeIn)));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1.0),
    ).animate(CurvedAnimation(parent: _animationController, curve: Interval(0.7, 1.0, curve: Curves.easeInOut)));

    // Delay the animation start
    Timer(const Duration(milliseconds: 1800), () {
      _animationController.forward();
    });

    _navigateToLandingPage();
  }

  void _navigateToLandingPage() {
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LandingPage(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dark background matching the logo's style
      backgroundColor: const Color(0xFF0A1920),
      body: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A1920),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      // Changed from teal to a purple glow
                      BoxShadow(color: const Color(0xFF9966CC).withOpacity(0.7), blurRadius: 25, spreadRadius: 3),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/logo.jpeg', fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Pathshala',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your digital companion for learning',
                  style: TextStyle(fontSize: 16, color: Color(0xFFE0E0E0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GlowingDot extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const GlowingDot({super.key, required this.size, required this.color, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(opacity * 0.7),
        boxShadow: [BoxShadow(color: color.withOpacity(opacity), blurRadius: size * 3, spreadRadius: size * 0.5)],
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  late AnimationController _typingController;
  late AnimationController _swipeGuideController;
  late Animation<Offset> _swipeLeftAnimation;
  late Animation<Offset> _swipeRightAnimation;
  final String _tagline = 'Your digital companion for learning';
  String _displayedTagline = '';
  int _selectedCardIndex = -1;
  bool _showSwipeGuide = false;

  // Random positions for glowing dots with complementary colors
  final List<Map<String, dynamic>> _glowingDots = List.generate(12, (index) {
    final random = Random();
    return {
      'position': Offset(
        random.nextDouble() * 0.9, // x position (0-1)
        random.nextDouble() * 0.9, // y position (0-1)
      ),
      'size': random.nextDouble() * 10 + 5, // size between 5-15
      'opacity': random.nextDouble() * 0.5 + 0.3, // opacity between 0.3-0.8
      'animationOffset': random.nextDouble() * 2, // offset for animation timing
      'color':
          index % 3 == 0
              ? const Color(0xFF9966CC) // Purple
              : index % 3 == 1
              ? const Color(0xFFE7A4FF) // Light purple
              : const Color(0xFFFF9F80), // Coral/Orange
    };
  });

  late List<AnimationController> _dotAnimationControllers;
  late List<Animation<double>> _dotAnimations;

  @override
  void initState() {
    super.initState();
    _typingController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

    _swipeGuideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

    _swipeLeftAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: const Offset(-0.3, 0),
    ).animate(CurvedAnimation(parent: _swipeGuideController, curve: Curves.easeInOut));

    _swipeRightAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: const Offset(0.3, 0),
    ).animate(CurvedAnimation(parent: _swipeGuideController, curve: Curves.easeInOut));

    _typingController.addListener(() {
      final progress = _typingController.value;
      final textLength = (_tagline.length * progress).round();
      setState(() {
        _displayedTagline = _tagline.substring(0, textLength);
      });
    });

    // Initialize animation controllers for each dot
    _dotAnimationControllers = List.generate(
      _glowingDots.length,
      (index) => AnimationController(vsync: this, duration: Duration(milliseconds: 1500 + Random().nextInt(1000))),
    );

    // Create pulsing animations for each dot
    _dotAnimations = List.generate(
      _glowingDots.length,
      (index) => Tween<double>(
        begin: 0.7,
        end: 1.5,
      ).animate(CurvedAnimation(parent: _dotAnimationControllers[index], curve: Curves.easeInOut)),
    );

    // Start dot animations with different timings
    for (int i = 0; i < _dotAnimationControllers.length; i++) {
      Future.delayed(Duration(milliseconds: (300 * i) % 1500), () {
        _dotAnimationControllers[i].repeat(reverse: true);
      });
    }

    // Start typing animation after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _typingController.forward();
    });

    // Show the swipe guide on initial load
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _showSwipeGuide = true;
        // Start swipe animation immediately
        _swipeGuideController.repeat(reverse: true);
      });
    });
  }

  @override
  void dispose() {
    _typingController.dispose();
    _swipeGuideController.dispose();
    for (var controller in _dotAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _navigateToTeacherLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherLogin()));
  }

  void _navigateToStudentLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => StudentLogin()));
  }

  void _onCardTap(int index) {
    setState(() {
      _selectedCardIndex = index;
    });
  }

  // Handle swipe globally - process the swipe based on direction and velocity
  void _handleSwipe(DragEndDetails details) {
    // Detect swipe with sufficient velocity (faster than 300 pixels per second)
    if (details.primaryVelocity != null && details.primaryVelocity!.abs() > 300) {
      if (details.primaryVelocity! < 0) {
        // Swiped left - go to student login
        _navigateToStudentLogin();
      } else {
        // Swiped right - go to teacher login
        _navigateToTeacherLogin();
      }
    }
  }

  Widget _buildRoleCard({
    required String title,
    required IconData icon,
    required int index,
    required VoidCallback onTap,
  }) {
    final bool isSelected = _selectedCardIndex == index;

    // Different colors for teacher and student cards - no more green/teal
    final Color primaryColor =
        index == 0
            ? const Color(0xFFF5A623) // Orange-gold for teacher
            : const Color(0xFFE7A4FF); // Light purple for student

    final Color glowColor =
        index == 0
            ? const Color(0xFFF5A623) // Orange-gold glow for teacher
            : const Color(0xFF9966CC); // Purple glow for student

    final Color cardBackground =
        index == 0
            ? const Color(0xFF0D2530).withOpacity(0.7) // Darker blue-green for teacher
            : const Color(0xFF14303D).withOpacity(0.7); // Lighter navy for student

    return GestureDetector(
      onTap: () => _onCardTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primaryColor : primaryColor.withOpacity(0.6),
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow:
              isSelected
                  ? [BoxShadow(color: glowColor.withOpacity(0.7), blurRadius: 15, spreadRadius: 2)]
                  : [BoxShadow(color: glowColor.withOpacity(0.3), blurRadius: 8, spreadRadius: 0)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [cardBackground.withOpacity(0.8), cardBackground.withOpacity(0.6)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 60, color: primaryColor),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(fontSize: isSelected ? 22 : 20, fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1920), // Dark navy background
      // Wrap entire body in GestureDetector to detect swipes anywhere
      body: GestureDetector(
        onHorizontalDragEnd: _handleSwipe,
        behavior: HitTestBehavior.translucent, // Make sure detector works across entire screen
        child: Stack(
          children: [
            // Background with gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF0A1920), const Color(0xFF14303D)], // Dark navy to slightly lighter navy
                ),
              ),
            ),

            // Glowing dots - more visible now with complementary colors
            ...List.generate(_glowingDots.length, (index) {
              final dot = _glowingDots[index];
              return Positioned(
                left: MediaQuery.of(context).size.width * dot['position'].dx,
                top: MediaQuery.of(context).size.height * dot['position'].dy,
                child: AnimatedBuilder(
                  animation: _dotAnimationControllers[index],
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _dotAnimations[index].value,
                      child: GlowingDot(size: dot['size'], color: dot['color'], opacity: dot['opacity']),
                    );
                  },
                ),
              );
            }),

            // Main content
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Centered app title and tagline with typing effect
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Removed the glow/shadow from the title
                        const Text(
                          'Pathshala',
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFFF8F9FA)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _displayedTagline,
                          style: const TextStyle(fontSize: 16, color: Color(0xFFF8F9FA)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Choose your role',
                          style: TextStyle(fontSize: 20, color: Color(0xFFF8F9FA), fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Vertical layout for role cards
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      children: [
                        _buildRoleCard(
                          title: 'Teacher',
                          icon: Icons.person_outline,
                          index: 0,
                          onTap: () {
                            _onCardTap(0);
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildRoleCard(
                          title: 'Student',
                          icon: Icons.school_outlined,
                          index: 1,
                          onTap: () {
                            _onCardTap(1);
                          },
                        ),
                      ],
                    ),
                  ),

                  // Swipe Guide - Always visible with working animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _showSwipeGuide ? 100 : 0,
                    curve: Curves.easeInOut,
                    child:
                        _showSwipeGuide
                            ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0A1920).withOpacity(0.9),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                border: Border(
                                  top: BorderSide(color: const Color(0xFF9966CC).withOpacity(0.5), width: 1.0),
                                  left: BorderSide(color: const Color(0xFF9966CC).withOpacity(0.3), width: 1.0),
                                  right: BorderSide(color: const Color(0xFF9966CC).withOpacity(0.3), width: 1.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF9966CC).withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Show both animations side by side
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        // Swipe right animation for teacher
                                        SlideTransition(
                                          position: _swipeRightAnimation,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.touch_app,
                                                color: const Color(0xFFF5A623), // Orange for teacher
                                                size: 24,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: const Color(0xFFF5A623), // Orange for teacher
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Swipe left animation for student
                                        SlideTransition(
                                          position: _swipeLeftAnimation,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_back_ios,
                                                color: const Color(0xFFE7A4FF), // Purple for student
                                                size: 20,
                                              ),
                                              Icon(
                                                Icons.touch_app,
                                                color: const Color(0xFFE7A4FF), // Purple for student
                                                size: 24,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        // Text for teacher swipe
                                        Expanded(
                                          child: Text(
                                            'Swipe right for\nTeacher Portal',
                                            style: TextStyle(
                                              color: const Color(0xFFF5A623),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),

                                        // Text for student swipe
                                        Expanded(
                                          child: Text(
                                            'Swipe left for\nStudent Portal',
                                            style: TextStyle(
                                              color: const Color(0xFFE7A4FF),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                            : const SizedBox.shrink(),
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
