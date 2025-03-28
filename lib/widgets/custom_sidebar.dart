import 'package:flutter/material.dart';
import '../screens/ar_games.dart';

class CustomSidebar extends StatefulWidget {
  const CustomSidebar({super.key});

  @override
  _CustomSidebarState createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isCollapsed ? 70 : 250,
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: Column(
        children: [
          IconButton(
            icon: Icon(isCollapsed ? Icons.menu : Icons.close, color: Colors.white),
            onPressed: () {
              setState(() {
                isCollapsed = !isCollapsed;
              });
            },
          ),
          _buildSidebarItem(Icons.dashboard, "Dashboard", context),
          _buildSidebarItem(Icons.class_, "Virtual Classrooms", context),
          _buildSidebarItem(Icons.person, "Teacher Consultants", context),
          _buildSidebarItem(Icons.assignment, "Tests", context),
          _buildSidebarItem(Icons.assignment_turned_in, "Assignments", context),

          // AR Games Navigation (Modified)
          ListTile(
            leading: Icon(Icons.videogame_asset, color: Colors.white),
            title: isCollapsed ? null : Text("AR Games", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ARGames()));
            },
          ),

          _buildSidebarItem(Icons.notifications, "Notifications", context),
          _buildSidebarItem(Icons.person_outline, "Profile", context),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: isCollapsed ? null : Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pushNamed(context, '/${title.toLowerCase().replaceAll(' ', '_')}');
      },
    );
  }
}
