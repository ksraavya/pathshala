import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GeminiService {
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  Future<String> getChatbotResponse(String userInput) async {
    final Uri url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent?key=$apiKey",
    );

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": userInput},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'] ?? "No response from Gemini.";
    } else {
      return "Error: ${response.statusCode}";
    }
  }
}
