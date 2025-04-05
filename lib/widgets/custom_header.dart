import 'package:flutter/material.dart';
import 'package:pathshala_dashboard/screens/landing_page.dart';
import 'package:pathshala_dashboard/screens/settings_screen.dart';

class CustomHeader extends StatelessWidget {
  final String currentPage;
  final VoidCallback onMenuTap;

  const CustomHeader({super.key, required this.currentPage, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Icon
          GestureDetector(onTap: onMenuTap, child: Icon(Icons.menu, color: Colors.white, size: 28)),

          // Current Page Navigation Path
          Row(
            children: [
              Icon(Icons.home, color: Colors.white, size: 20),
              SizedBox(width: 5),
              Text(" / $currentPage", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),

          // Search Bar (Optional, can be expanded later)
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.blueGrey[800],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  prefixIcon: Icon(Icons.search, color: Colors.white54),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          // Exit & Settings Icons
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.exit_to_app, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
                },
              ),
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
