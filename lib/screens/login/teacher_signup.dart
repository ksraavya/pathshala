import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../widgets/custom_button.dart';

class TeacherSignup extends StatefulWidget {
  const TeacherSignup({super.key});

  @override
  _TeacherSignupState createState() => _TeacherSignupState();
}

class _TeacherSignupState extends State<TeacherSignup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Dim Overlay
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/teacher_bg.png"), fit: BoxFit.cover),
            ),
            child: Container(color: Colors.black.withOpacity(0.7)),
          ),

          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Teacher Sign Up",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ).animate().fade().scale(),
                          SizedBox(height: 20),

                          _buildTextField(_emailController, _emailFocus, "Email", Icons.email),
                          SizedBox(height: 15),

                          _buildTextField(
                            _passwordController,
                            _passwordFocus,
                            "Password",
                            Icons.lock,
                            obscureText: true,
                          ),
                          SizedBox(height: 15),

                          _buildTextField(
                            _confirmPasswordController,
                            _confirmPasswordFocus,
                            "Confirm Password",
                            Icons.lock_outline,
                            obscureText: true,
                          ),
                          SizedBox(height: 20),

                          _buildSignupButton(),
                          SizedBox(height: 10),
                          _buildLoginLink(),
                        ],
                      ).animate().fade(duration: 600.ms).slideY(begin: 0.3, end: 0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    FocusNode focusNode,
    String hint,
    IconData icon, {
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFC610E7), width: 2),
        ),
      ),
    ).animate().fade().moveY(begin: 20, end: 0);
  }

  Widget _buildSignupButton() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Color(0xFF9B51E0).withOpacity(0.6), blurRadius: 15, spreadRadius: 2)],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Opacity(
        opacity: 0.9,
        child:
            CustomButton(
              color: Color(0xFF9B51E0),
              text: "Sign Up",
              onPressed: () {
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _passwordController.text == _confirmPasswordController.text) {
                  Get.toNamed('/teacher_dashboard');
                } else {
                  EasyLoading.showError("Please enter valid details");
                }
              },
            ).animate().fade(duration: 500.ms).scale(),
      ),
    );
  }

  Widget _buildLoginLink() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/teacher_login');
        },
        child: Text(
          "Already have an account? Login",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationColor: Colors.white,
            decorationThickness: 2,
          ),
        ),
      ).animate().fade(duration: 600.ms),
    );
  }
}
