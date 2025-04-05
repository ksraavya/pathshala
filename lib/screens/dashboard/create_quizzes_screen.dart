import 'package:flutter/material.dart';
import 'quiz_creation_screen.dart';

class CreateQuizzesScreen extends StatelessWidget {
  const CreateQuizzesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Quizzes'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildSubjectCard(
                context,
                'Mathematics',
                Icons.calculate,
                'Create math quizzes with various topics like algebra, geometry, calculus etc.',
              ),
              _buildSubjectCard(
                context,
                'Physics',
                Icons.science,
                'Design physics quizzes covering mechanics, electricity, waves and more.',
              ),
              _buildSubjectCard(
                context,
                'Chemistry',
                Icons.science_outlined,
                'Build chemistry quizzes on organic, inorganic and physical chemistry.',
              ),
              _buildSubjectCard(
                context,
                'Biology',
                Icons.biotech,
                'Create biology quizzes on anatomy, genetics, ecology and more.',
              ),
              _buildSubjectCard(
                context,
                'Computer Science',
                Icons.computer,
                'Design programming and computer theory quizzes.',
              ),
              _buildSubjectCard(context, 'English', Icons.menu_book, 'Create language and literature quizzes.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, String title, IconData icon, String description) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(title, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                Icon(icon, size: 28.0),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(description, style: const TextStyle(fontSize: 14.0, color: Colors.grey)),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add, size: 16.0),
                    label: const Text('CREATE NEW'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizCreationScreen(subject: title)),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.edit, size: 16.0),
                    label: const Text('MANAGE'),
                    onPressed: () {
                      // TODO: Implement manage quizzes functionality
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
