import 'package:flutter/material.dart';
import 'package:pathshala_dashboard/widgets/gradient_scaffold.dart';

class QuizPlayScreen extends StatefulWidget {
  final String subject;
  const QuizPlayScreen({super.key, required this.subject});

  @override
  _QuizPlayScreenState createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  String? selectedAnswer;
  bool answerSelected = false;

  final Map<String, List<Map<String, dynamic>>> questions = {
    "Mathematics": [
      {
        "question": "What is the value of π (pi) to two decimal places?",
        "options": ["3.14", "3.41", "3.24", "3.42"],
        "answer": "3.14",
      },
      {
        "question": "Solve for x: 2x + 5 = 13",
        "options": ["x = 2", "x = 3", "x = 4", "x = 5"],
        "answer": "x = 4",
      },
      {
        "question": "What is the square root of 144?",
        "options": ["9", "10", "11", "12"],
        "answer": "12",
      },
      {
        "question": "If the angles of a triangle are 45°, 45° and 90°, what type of triangle is it?",
        "options": ["Equilateral", "Isosceles", "Scalene", "Obtuse"],
        "answer": "Isosceles",
      },
      {
        "question": "What is the area of a circle with radius 5 units?",
        "options": ["5π", "25π", "50π", "100π"],
        "answer": "25π",
      },
      {
        "question": "What is the next number in the sequence: 2, 4, 8, 16...?",
        "options": ["32", "48", "56", "60"],
        "answer": "32",
      },
      {
        "question": "What is the value of 5! (5 factorial)?",
        "options": ["100", "120", "150", "180"],
        "answer": "120",
      },
      {
        "question": "If sin(30°) is 0.5, then what is the value of cos(60°)?",
        "options": ["0.3", "0.4", "0.5", "0.6"],
        "answer": "0.5",
      },
      {
        "question": "What is the derivative of x²?",
        "options": ["x", "2x", "x²", "2x²"],
        "answer": "2x",
      },
      {
        "question": "What is the sum of the first 10 natural numbers?",
        "options": ["45", "50", "55", "60"],
        "answer": "55",
      },
    ],
    "Physics": [
      {
        "question": "What is the unit of force?",
        "options": ["Newton", "Joule", "Watt", "Pascal"],
        "answer": "Newton",
      },
      {
        "question": "What is the speed of light?",
        "options": ["3x10^8 m/s", "1x10^6 m/s", "5x10^7 m/s", "2x10^5 m/s"],
        "answer": "3x10^8 m/s",
      },
      {
        "question": "What is the formula for kinetic energy?",
        "options": ["KE = 1/2 mv²", "KE = mv²", "KE = 2mv²", "KE = 1/2 mv"],
        "answer": "Newton",
      },
      {
        "question": "What is the law of conservation of energy?",
        "options": [
          "Energy can both be created and destroyed",
          "Energy cannot be created but can be destroyed",
          "Energy cannot be created or destroyed",
          "Energy can be created but cannot be destroyed",
        ],
        "answer": "Energy cannot be created or destroyed",
      },
      {
        "question": "What is the unit of electric current?",
        "options": ["Watt", "Ohm", "Volt", "Ampere"],
        "answer": "Ampere",
      },
      {
        "question": "What is the formula for gravitational force?",
        "options": ["F = Gm₁m₂/r", "F = Gm₁m₂/r²", "F = Gm₁m₂/r³", "F = Gm₁m₂/r⁴"],
        "answer": "F = Gm₁m/r²",
      },
      {
        "question": "What is the principle of relativity?",
        "options": [
          "Laws of physics are the same in all inertial frames",
          "Laws of physics change in some frames",
          "Only some laws are same in all frames",
          "Laws of physics are different in all frames",
        ],
        "answer": "Laws of physics are the same in all inertial frames",
      },
      {
        "question": "What is the unit of frequency?",
        "options": ["Newton", "Joule", "Hertz", "Pascal"],
        "answer": "Hertz",
      },
      {
        "question": "What is the law of conservation of momentum?",
        "options": [
          "Momentum can be created",
          "Total momentum remains conserved in a closed system",
          "Momentum can be destroyed",
          "Momentum changes randomly",
        ],
        "answer": "Newton",
      },
      {
        "question": "What is the formula for power?",
        "options": ["P = W/t", "P = Wt", "P = W/t²", "P = W²/t"],
        "answer": "P = W/t",
      },
    ],
    "Chemistry": [
      {
        "question": "What is the atomic number of Carbon?",
        "options": ["5", "6", "7", "8"],
        "answer": "6",
      },
      {
        "question": "What is the chemical symbol for Gold?",
        "options": ["Ni", "Cu", "Ag", "Au"],
        "answer": "Au",
      },
      {
        "question": "What is the formula for water?",
        "options": ["H₂O", "O₂", "H₂O₂", "CO₂"],
        "answer": "H₂O",
      },
      {
        "question": "What is the pH of a neutral solution?",
        "options": ["1", "7", "8", "14"],
        "answer": "7",
      },
      {
        "question": "What is the most abundant element in the universe?",
        "options": ["Oxygen", "Nitrogen", "Hydrogen", "Carbon"],
        "answer": "Hydrogen",
      },
      {
        "question": "What is the process of a liquid turning into a gas?",
        "options": ["Condensation", "Deposition", "Sublimation", "Evaporation"],
        "answer": "Evaporation",
      },
      {
        "question": "What is the atomic mass unit of Carbon-12?",
        "options": ["3", "6", "12", "24"],
        "answer": "12",
      },
      {
        "question": "What is the name of the process where plants convert CO₂ to glucose?",
        "options": ["Respiration", "Photosynthesis", "Fermentation", "Digestion"],
        "answer": "Photosynthesis",
      },
      {
        "question": "What is the charge on an electron?",
        "options": ["-1", "+1", "0", "-2"],
        "answer": "-1",
      },
      {
        "question": "What is the name of the bond formed by sharing of electrons?",
        "options": ["Metallic", "Ionic", "Hydrogen", "Covalent"],
        "answer": "Covalent",
      },
    ],
    "Biology": [
      {
        "question": "What is the powerhouse of the cell?",
        "options": ["Nucleus", "Mitochondria", "Golgi body", "Ribosome"],
        "answer": "Mitochondria",
      },
      {
        "question": "What is the process by which plants make their own food?",
        "options": ["Excretion", "Respiration", "Digestion", "Photosynthesis"],
        "answer": "Photosynthesis",
      },
      {
        "question": "What is the largest organ in the human body?",
        "options": ["Liver", "Heart", "Skin", "Brain"],
        "answer": "Skin",
      },
      {
        "question": "What is the basic unit of life?",
        "options": ["Cell", "Atom", "Tissue", "Molecule"],
        "answer": "Cell",
      },
      {
        "question": "What is the process of cell division?",
        "options": ["Fission", "Mitosis", "Budding", "Meiosis"],
        "answer": "Mitosis",
      },
      {
        "question": "What is the study of heredity called?",
        "options": ["Zoology", "Physiology", "Ecology", "Genetics"],
        "answer": "Genetics",
      },
      {
        "question": "What is the main function of red blood cells?",
        "options": ["Fight infection", "Digest food", "Transport oxygen", "Produce hormones"],
        "answer": "Transport oxygen",
      },
      {
        "question": "What is the name of the process where DNA is copied?",
        "options": ["Transcription", "Replication", "Translation", "Mutation"],
        "answer": "Replication",
      },
      {
        "question": "What is the largest part of the brain?",
        "options": ["Cerebrum", "Cerebellum", "Brain stem", "Hypothallamus"],
        "answer": "Cerebrum",
      },
      {
        "question": "What is the process of breaking down food called?",
        "options": ["Respiration", "Absorption", "Excretion", "Digestion"],
        "answer": "Digestion",
      },
    ],
    "Computer Science": [
      {
        "question": "What is the brain of a computer?",
        "options": ["Monitor", "CPU", "Keyboard", "Mouse"],
        "answer": "CPU",
      },
      {
        "question": "Which of the following is an input device?",
        "options": ["Printer", "Monitor", "Keyboard", "Speaker"],
        "answer": "Keyboard",
      },
      {
        "question": "Which key is used to start a new line in a text document?",
        "options": ["Enter", "Spacebar", "Shift", "Backspace"],
        "answer": "Enter",
      },
      {
        "question": "Which of the following is a type of software?",
        "options": ["Mouse", "RAM", "Hard drive", "Windows"],
        "answer": "Windows",
      },
      {
        "question": "Which of the following is a web browser?",
        "options": ["MS Word", "Google Chrome", "Windows", "Photoshop"],
        "answer": "Google Chrome",
      },
      {
        "question": "Which device is used to store data permanently?",
        "options": ["RAM", "CPU", "Hard drive", "Monitor"],
        "answer": "Hard drive",
      },
      {
        "question": "What is the full form of USB?",
        "options": ["Universal Serial Bus", "United Storage Block", "Unique Software Base", "Universal System Backup"],
        "answer": "Universal Serial Bus",
      },
      {
        "question": "Which of these is NOT a programming language?",
        "options": ["Python", "Google", "Java", "C++"],
        "answer": "0.5",
      },
      {
        "question": "Which part of the computer displays the output?",
        "options": ["Mouse", "CPU", "Keyboard", "Monitor"],
        "answer": "Monitor",
      },
      {
        "question": "Which symbol is used in email addresses?",
        "options": ["&", "@", "#", "\$"],
        "answer": "@",
      },
    ],
    "English": [
      {
        "question": "What is the past tense of 'go'?",
        "options": ["gone", "went", "go", "goed"],
        "answer": "went",
      },
      {
        "question": "Which of these is a proper noun?",
        "options": ["London", "city", "country", "continent"],
        "answer": "London",
      },
      {
        "question": "What is the plural form of 'child'?",
        "options": ["child", "childs", "childes", "children"],
        "answer": "children",
      },
      {
        "question": "Which word is an antonym of 'happy'?",
        "options": ["sad", "joyful", "ecstatic", "mad"],
        "answer": "sad",
      },
      {
        "question": "What is the correct form of the verb in: 'She ___ to school every day.'",
        "options": ["go", "gone", "goes", "going"],
        "answer": "goes",
      },
      {
        "question": "Which of these is a preposition?",
        "options": ["in", "happy", "run", "book"],
        "answer": "in",
      },
      {
        "question": "What is the comparative form of 'good'?",
        "options": ["gooder", "better", "more good", "best"],
        "answer": "better",
      },
      {
        "question": "Which sentence is in the present perfect tense?",
        "options": [
          "I am finishing my homework",
          "I finished my homework",
          "I finish my homework",
          "I have finished my homework",
        ],
        "answer": "I have finished my homework",
      },
      {
        "question": "What is the opposite of 'begin'?",
        "options": ["start", "middle", "end", "continue"],
        "answer": "end",
      },
      {
        "question": "Which word is a synonym of 'beautiful'?",
        "options": ["ugly", "pretty", "plain", "simple"],
        "answer": "pretty",
      },
    ],
  };

  void checkAnswer(String selectedOption) {
    if (!answerSelected) {
      setState(() {
        selectedAnswer = selectedOption;
        answerSelected = true;
        if (selectedOption == questions[widget.subject]![currentQuestionIndex]["answer"]) {
          score++;
        }
      });
      Future.delayed(Duration(seconds: 1), nextQuestion);
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions[widget.subject]!.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        answerSelected = false;
      });
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Quiz Completed!"),
              content: Text("Your Score: $score/${questions[widget.subject]!.length}"),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(title: Text("${widget.subject} Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q${currentQuestionIndex + 1}: ${questions[widget.subject]![currentQuestionIndex]["question"]}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children:
                  questions[widget.subject]![currentQuestionIndex]["options"].map<Widget>((option) {
                    bool isCorrect = option == questions[widget.subject]![currentQuestionIndex]["answer"];
                    bool isSelected = option == selectedAnswer;
                    return GestureDetector(
                      onTap: () => checkAnswer(option),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected ? (isCorrect ? Colors.green : Colors.red) : Colors.grey,
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                            if (answerSelected && isCorrect)
                              BoxShadow(color: Colors.green, blurRadius: 5, spreadRadius: 1),
                          ],
                        ),
                        child: Text(option, style: TextStyle(fontSize: 18)),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
