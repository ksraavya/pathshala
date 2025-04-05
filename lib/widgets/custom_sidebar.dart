import 'package:flutter/material.dart';
import 'package:pathshala_dashboard/screens/dashboard/student_dashboard.dart';
import 'package:pathshala_dashboard/screens/dashboard/teacher_dashboard.dart';
import 'package:pathshala_dashboard/screens/dashboard/virtual_classroom_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/ar_learning_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/quiz_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/chatbot_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/notifications_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/profile_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/classroom_links_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/create_quizzes_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/upload_ar_models_screen.dart';

class CustomSidebar extends StatefulWidget {
  final String userType; // 'student' or 'teacher'

  const CustomSidebar({super.key, required this.userType});

  @override
  _CustomSidebarState createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;

  void toggleSidebar() {
    setState(() {
      isCollapsed = !isCollapsed;
    });
  }

  void _navigateTo(String label) {
    // Close the sidebar before navigating
    setState(() {
      isCollapsed = true;
    });

    switch (label) {
      case 'Dashboard':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => widget.userType == 'teacher' ? TeacherDashboard() : StudentDashboard(),
          ),
        );
        break;
      case 'Virtual Classroom':
        Navigator.push(context, MaterialPageRoute(builder: (context) => VirtualClassroomScreen()));
        break;
      case 'AR Learning':
        Navigator.push(context, MaterialPageRoute(builder: (context) => ARLearningScreen()));
        break;
      case 'Quiz':
        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()));
        break;
      case 'Chatbot':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    widget.userType == 'student' ? ChatbotScreen(isTeacher: false) : ChatbotScreen(isTeacher: true),
          ),
        );
        break;
      case 'Notifications':
        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen()));
        break;
      case 'Profile':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    widget.userType == 'student' ? ProfileScreen(isTeacher: false) : ProfileScreen(isTeacher: true),
          ),
        );
        break;
      case 'Classroom Links':
        Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomLinksScreen()));
        break;
      case 'Create Quizzes':
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuizzesScreen()));
        break;
      case 'Upload AR Models':
        Navigator.push(context, MaterialPageRoute(builder: (context) => UploadARModelScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hamburger menu button - always visible
        Positioned(
          top: MediaQuery.of(context).padding.top + 20,
          left: 20,
          child: GestureDetector(
            onTap: toggleSidebar,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCollapsed ? Colors.blueGrey[900] : Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: isCollapsed ? [BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1)] : [],
              ),
              child: Icon(isCollapsed ? Icons.menu : Icons.close, color: Colors.white, size: 24),
            ),
          ),
        ),

        // Sidebar panel
        if (!isCollapsed)
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: isCollapsed ? -250 : 0,
            top: 0,
            bottom: 0,
            width: 250,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)],
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top + 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.school, color: Colors.white, size: 30),
                              SizedBox(width: 10),
                              Text(
                                "Pathshala",
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(icon: Icon(Icons.close, color: Colors.white), onPressed: toggleSidebar),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.white54),
                    Expanded(child: SingleChildScrollView(child: Column(children: _sidebarItems()))),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _sidebarItems() {
    final studentItems = [
      {'icon': Icons.dashboard, 'label': 'Dashboard'},
      {'icon': Icons.video_call, 'label': 'Virtual Classroom'},
      {'icon': Icons.vrpano, 'label': 'AR Learning'},
      {'icon': Icons.quiz, 'label': 'Quiz'},
      {'icon': Icons.chat, 'label': 'Chatbot'},
      {'icon': Icons.notifications, 'label': 'Notifications'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    final teacherItems = [
      {'icon': Icons.dashboard, 'label': 'Dashboard'},
      {'icon': Icons.quiz, 'label': 'Create Quizzes'},
      {'icon': Icons.vrpano, 'label': 'Upload AR Models'},
      {'icon': Icons.create, 'label': 'Classroom Links'},
      {'icon': Icons.chat, 'label': 'Chatbot'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    final items = widget.userType == 'teacher' ? teacherItems : studentItems;

    return items.map((item) {
      return InkWell(
        onTap: () => _navigateTo(item['label'] as String),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Row(
            children: [
              Icon(item['icon'] as IconData, color: Colors.white, size: 24),
              SizedBox(width: 15),
              Text(item['label'] as String, style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
      );
    }).toList();
  }
}
