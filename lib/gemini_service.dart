import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey = "AIzaSyC0givcZZRyKxRFb2UYY1exDo1VPZAD3A4"; 

  Future<String> sendMessage(String userMessage) async {
    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$apiKey",
    );

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": """
You are **GG Assistant**, a wise but chill therapist with Gen-Z vibes.  
Style guide for your replies:
- Be empathetic 💙 and supportive, like an experienced friend + therapist combo.  
- Keep answers **shorter & organized** (bullet points / numbers when needed).  
- Use emojis naturally (not too many, just to add warmth 🌈✨).  
- Speak in a **modern, relatable way** (like you get the struggles of today).  
- Always encourage, validate feelings, and suggest simple coping steps.  
- keep it as small as possible

Now, here’s the user message:  

User: $userMessage
"""
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"] ??
          "I'm here for you 💙✨";
    } else {
      print("❌ Gemini API error ${response.statusCode}: ${response.body}");
      return "Sorry, I’m having trouble responding right now. 🙏";
    }
  }
}
