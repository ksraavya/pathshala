import 'package:flutter/material.dart';
import 'package:pathshala_dashboard/widgets/gradient_scaffold.dart';
import 'quiz_play_screen.dart';

class QuizScreen extends StatelessWidget {
  final List<Map<String, dynamic>> quizzes = [
    {"title": "Mathematics", "icon": Icons.calculate, "description": "Test your knowledge in mathematics."},
    {"title": "Physics", "icon": Icons.science, "description": "Test your knowledge in physics."},
    {"title": "Chemistry", "icon": Icons.biotech, "description": "Test your knowledge in chemistry."},
    {"title": "Biology", "icon": Icons.eco, "description": "Test your knowledge in biology."},
    {"title": "Computer Science", "icon": Icons.computer, "description": "Test your knowledge in computer science."},
    {"title": "English", "icon": Icons.book, "description": "Test your knowledge in English."},
  ];

  QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          var quiz = quizzes[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(quiz["icon"], size: 40, color: Colors.blue),
                      SizedBox(width: 16),
                      Expanded(child: Text(quiz["title"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(quiz["description"], style: TextStyle(color: Colors.grey[700])),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuizPlayScreen(subject: quiz["title"])),
                        );
                      },
                      child: Text("Take Quiz"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
