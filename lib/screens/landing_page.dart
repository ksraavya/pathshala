import 'dart:ui';
import 'package:flutter/material.dart';
import 'student_login.dart';
import 'teacher_login.dart';
import 'package:animate_do/animate_do.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Gradient Overlay
          Positioned.fill(
            child: Stack(
              children: [
                Image.asset(
                  "assets/land_bg.png", // Ensure this path is correct
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Welcome Text with Tagline
                  FadeInDown(
                    delay: Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        Text(
                          "Welcome to Pathshala",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 5, offset: Offset(2, 2)),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Your Digital Learning Companion!",
                          style: TextStyle(fontSize: 18, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),

                  // Cards Column for Better Mobile Layout
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInUp(
                        child: _buildGlassCard(
                          context,
                          "Teacher",
                          Icons.person_outline,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherLogin())),
                        ),
                      ),
                      SizedBox(height: 20),
                      FadeInUp(
                        delay: Duration(milliseconds: 200),
                        child: _buildGlassCard(
                          context,
                          "Student",
                          Icons.school_outlined,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudentLogin())),
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

  Widget _buildGlassCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 60, color: Colors.white),
                SizedBox(height: 10),
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
