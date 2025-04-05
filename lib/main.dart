import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pathshala_dashboard/screens/dashboard/create_quizzes_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/upload_ar_models_screen.dart';
import 'package:pathshala_dashboard/screens/landing_page.dart';
import 'package:pathshala_dashboard/screens/login/student_login.dart';
import 'package:pathshala_dashboard/screens/login/teacher_login.dart';
import 'package:pathshala_dashboard/screens/login/student_signup.dart';
import 'package:pathshala_dashboard/screens/login/teacher_signup.dart';
import 'package:pathshala_dashboard/screens/dashboard/student_dashboard.dart';
import 'package:pathshala_dashboard/screens/dashboard/teacher_dashboard.dart';
import 'package:pathshala_dashboard/screens/dashboard/virtual_classroom_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/ar_learning_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/quiz_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/notifications_screen.dart';
import 'package:pathshala_dashboard/screens/dashboard/profile_screen.dart';
import 'package:pathshala_dashboard/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Load environment variables
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
        // Authentication screens
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/student_login', page: () => const StudentLogin()),
        GetPage(name: '/teacher_login', page: () => const TeacherLogin()),
        GetPage(name: '/student_signup', page: () => const StudentSignup()),
        GetPage(name: '/teacher_signup', page: () => const TeacherSignup()),

        // Student routes
        GetPage(name: '/student_dashboard', page: () => StudentDashboard()),
        GetPage(name: '/student/virtual_classroom', page: () => VirtualClassroomScreen()),
        GetPage(name: '/student/ar_learning', page: () => ARLearningScreen()),
        GetPage(name: '/student/quiz', page: () => QuizScreen()),
        GetPage(name: '/student/notifications', page: () => NotificationsScreen()),
        GetPage(name: '/student/profile', page: () => ProfileScreen()),

        // Teacher routes
        GetPage(name: '/teacher_dashboard', page: () => const TeacherDashboard()),
        GetPage(name: '/teacher/virtual_classroom', page: () => VirtualClassroomScreen()),
        GetPage(name: '/teacher/upload_ar_models', page: () => UploadARModelScreen()),
        GetPage(name: '/teacher/create_quizzes', page: () => CreateQuizzesScreen()),
        GetPage(name: '/teacher/profile', page: () => ProfileScreen()),
      ],
    );
  }
}
