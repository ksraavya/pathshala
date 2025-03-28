import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pathshala_dashboard/screens/student_dashboard.dart';
import '../widgets/custom_button.dart';
import 'package:animate_do/animate_do.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Dim Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/teacher_bg.png"), fit: BoxFit.cover),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.5), // Dim overlay
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated Login Box
                  FadeInDown(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2), // More transparent
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Overlapping Circle Avatar with Animation
                              FadeIn(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  child: Icon(Icons.person, size: 50, color: Colors.white),
                                ),
                              ),

                              SizedBox(height: 10),
                              Text(
                                "Teacher Login",
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              SizedBox(height: 20),

                              // Email Input Field
                              FadeInLeft(
                                child: TextField(
                                  controller: _emailController,
                                  focusNode: _emailFocus,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.white70),
                                    prefixIcon: Icon(Icons.email, color: Colors.white),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.15),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),

                              // Password Input Field
                              FadeInRight(
                                child: TextField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocus,
                                  obscureText: true,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.white70),
                                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.15),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              // Neon Glow Login Button with Animation
                              FadeInUp(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF9B51E0).withOpacity(0.6), // Neon purple glow
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Opacity(
                                    opacity: 0.9,
                                    child: CustomButton(
                                      color: Color(0xFF9B51E0), // Neon Purple
                                      text: "Login",
                                      onPressed: () {
                                        if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                                          Get.to(() => StudentDashboard());
                                        } else {
                                          EasyLoading.showError("Enter valid credentials");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),

                              // Sign Up Link
                              FadeInUp(
                                delay: Duration(milliseconds: 200),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/teacher_signup');
                                    },
                                    child: Text(
                                      "Don't have an account? Sign Up",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
