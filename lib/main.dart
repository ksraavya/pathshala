import 'package:flutter/material.dart';
import 'package:pathshala_dashboard/screens/landing_page.dart';
import 'package:pathshala_dashboard/screens/student_login.dart';
import 'package:pathshala_dashboard/screens/teacher_login.dart';
import 'package:pathshala_dashboard/screens/student_signup.dart';
import 'package:pathshala_dashboard/screens/teacher_signup.dart';
import 'package:pathshala_dashboard/screens/student_dashboard.dart';
import 'package:pathshala_dashboard/screens/teacher_dashboard.dart';
import 'package:pathshala_dashboard/utils/theme.dart';
import 'package:get/get.dart';

void main() {
  runApp(const PathshalaApp());
}

class PathshalaApp extends StatelessWidget {
  const PathshalaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pathshala Dashboard',
      theme: appTheme,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const LandingPage()),
        GetPage(name: '/student_login', page: () => const StudentLogin()),
        GetPage(name: '/teacher_login', page: () => const TeacherLogin()),
        GetPage(name: '/student_signup', page: () => const StudentSignup()),
        GetPage(name: '/teacher_signup', page: () => const TeacherSignup()),
        GetPage(name: '/student_dashboard', page: () => StudentDashboard()),
        GetPage(name: '/teacher_dashboard', page: () => const TeacherDashboard()),
      ],
    );
  }
}
