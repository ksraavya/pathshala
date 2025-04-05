import 'package:flutter/material.dart';
import 'package:pathshala_dashboard/widgets/gradient_scaffold.dart';

class Question {
  String question;
  List<String> options;
  int correctAnswerIndex;
  String? explanation;

  Question({required this.question, required this.options, required this.correctAnswerIndex, this.explanation});
}

class QuizCreationScreen extends StatefulWidget {
  final String subject;

  const QuizCreationScreen({Key? key, required this.subject}) : super(key: key);

  @override
  State<QuizCreationScreen> createState() => _QuizCreationScreenState();
}

class _QuizCreationScreenState extends State<QuizCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _quizTitle = '';
  String _quizDescription = '';
  int _timeLimit = 30;
  List<Question> _questions = [];

  @override
  void initState() {
    super.initState();
    // Add two empty questions by default
    _questions.add(Question(question: '', options: ['', '', '', ''], correctAnswerIndex: 0));
    _questions.add(Question(question: '', options: ['', '', '', ''], correctAnswerIndex: 0));
  }

  void _addQuestion() {
    setState(() {
      _questions.add(Question(question: '', options: ['', '', '', ''], correctAnswerIndex: 0));
    });
  }

  void _removeQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
  }

  void _saveQuiz() {
    // This would be where you'd actually save the quiz to your backend
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Quiz saved successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        title: Text('${widget.subject} Quiz'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quiz Title', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quiz title';
                  }
                  return null;
                },
                onChanged: (value) {
                  _quizTitle = value;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Time Limit (minutes)', border: OutlineInputBorder()),
                initialValue: '30',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a time limit';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onChanged: (value) {
                  _timeLimit = int.tryParse(value) ?? 30;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quiz Description', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quiz description';
                  }
                  return null;
                },
                onChanged: (value) {
                  _quizDescription = value;
                },
              ),
              const SizedBox(height: 24.0),
              ...List.generate(_questions.length, (index) {
                return _buildQuestionCard(index);
              }),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('ADD QUESTION'),
                  onPressed: _addQuestion,
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('SAVE QUIZ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveQuiz();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int questionIndex) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${questionIndex + 1}',
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                if (_questions.length > 1)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeQuestion(questionIndex),
                  ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Question', border: OutlineInputBorder()),
              initialValue: _questions[questionIndex].question,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a question';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _questions[questionIndex].question = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Option 1', border: OutlineInputBorder()),
              initialValue: _questions[questionIndex].options[0],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an option';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _questions[questionIndex].options[0] = value;
                });
              },
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Option 2', border: OutlineInputBorder()),
              initialValue: _questions[questionIndex].options[1],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an option';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _questions[questionIndex].options[1] = value;
                });
              },
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Option 3', border: OutlineInputBorder()),
              initialValue: _questions[questionIndex].options[2],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an option';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _questions[questionIndex].options[2] = value;
                });
              },
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Option 4', border: OutlineInputBorder()),
              initialValue: _questions[questionIndex].options[3],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an option';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _questions[questionIndex].options[3] = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Correct Answer', border: OutlineInputBorder()),
              value: _questions[questionIndex].correctAnswerIndex,
              items: [
                DropdownMenuItem(value: 0, child: Text('Option 1')),
                DropdownMenuItem(value: 1, child: Text('Option 2')),
                DropdownMenuItem(value: 2, child: Text('Option 3')),
                DropdownMenuItem(value: 3, child: Text('Option 4')),
              ],
              onChanged: (value) {
                setState(() {
                  _questions[questionIndex].correctAnswerIndex = value!;
                });
              },
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Explanation (Optional)', border: OutlineInputBorder()),
              initialValue: _questions[questionIndex].explanation,
              onChanged: (value) {
                setState(() {
                  _questions[questionIndex].explanation = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
