import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final TextEditingController controller;
  final bool obscureText;
  final Color backgroundColor;

  const InputField({
    super.key,
    required this.hintText,
    this.icon,
    required this.controller,
    this.obscureText = false,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // Use the passed background color
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.white),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
