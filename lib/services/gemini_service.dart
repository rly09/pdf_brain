import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static final _apiKey = dotenv.env['GEMINI_API_KEY'];

  static Future<String> summarizeText(String text) async {
    if (_apiKey == null) return 'API key not found.';

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: _apiKey!,
      );

      final prompt =
          'Summarize the following text into short bullet points, no extra sentences:\n\n$text';
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? 'No summary generated.';
    } catch (e) {
      print("Gemini error: $e");
      return 'Error generating summary.';
    }
  }

  static Future<List<String>> extractKeywords(String text) async {
    if (_apiKey == null) return [];

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: _apiKey!,
      );

      final prompt =
          'From the following text, extract exactly 7 single or two-word important keywords only, '
          'separated by commas, without numbering or extra words:\n\n$text';

      final response = await model.generateContent([Content.text(prompt)]);
      final output = response.text ?? '';

      // Clean output to remove any unwanted symbols or numbers
      final keywords = output
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty && RegExp(r'^[A-Za-z0-9\s]+$').hasMatch(e))
          .toSet() // Remove duplicates
          .take(7) // Limit to 7
          .toList();

      return keywords;
    } catch (e) {
      print("Gemini keyword error: $e");
      return [];
    }
  }
}
