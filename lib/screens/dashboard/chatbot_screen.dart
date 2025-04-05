import 'package:flutter/material.dart';
import 'package:pathshala_dashboard/services/gemini_service.dart';

class ChatbotScreen extends StatefulWidget {
  final bool isTeacher; // Determines if the user is a teacher or student

  const ChatbotScreen({super.key, required this.isTeacher});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  void _sendMessage() async {
    String userMessage = _messageController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": userMessage});
      _messageController.clear();
      _isLoading = true;
    });

    final gemini = GeminiService();
    String botResponse = await gemini.getChatbotResponse(userMessage);

    setState(() {
      _messages.add({"role": "bot", "text": botResponse});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isTeacher ? "Teacher Chatbot" : "Student Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var message = _messages[index];
                bool isUser = message["role"] == "user";

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message["text"] ?? "", style: TextStyle(color: isUser ? Colors.white : Colors.black)),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) Padding(padding: const EdgeInsets.all(10), child: CircularProgressIndicator()),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Ask something...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
