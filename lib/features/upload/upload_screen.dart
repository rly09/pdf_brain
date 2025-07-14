import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';

import '../../screens/result_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool isLoading = false;

  Future<void> pickAndExtractText() async {
    setState(() => isLoading = true);

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) {
        setState(() => isLoading = false);
        return;
      }

      final fileBytes = File(result.files.single.path!).readAsBytesSync();
      final PdfDocument document = PdfDocument(inputBytes: fileBytes);
      String extractedText = PdfTextExtractor(document).extractText();
      document.dispose();

      setState(() => isLoading = false);

      if (extractedText.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('⚠️ No text found in PDF')),
        );
        return;
      }

      // ✨ Generate bullet-point summary
      List<String> summaryPoints = extractedText
          .split('. ')
          .where((sentence) => sentence.trim().length > 30)
          .take(5)
          .map((s) => s.trim() + '.')
          .toList();

      // 🧠 Extract keywords (basic word frequency)
      Map<String, int> wordCount = {};
      for (var word in extractedText
          .toLowerCase()
          .replaceAll(RegExp(r'[^\w\s]'), '')
          .split(' ')) {
        if (word.length > 3) {
          wordCount[word] = (wordCount[word] ?? 0) + 1;
        }
      }

      final sortedEntries = wordCount.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      List<String> keywords = sortedEntries.take(6).map((e) => e.key).toList();


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            summaryPoints: summaryPoints,
            keywords: keywords,
          ),
        ),
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: const Text('PDF Brain'),
        backgroundColor: isDark ? Colors.deepPurple[400] : Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.picture_as_pdf,
              size: 80,
              color: isDark ? Colors.purple[200] : Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                "Upload a PDF to get an offline summary and keywords, visualized beautifully.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: pickAndExtractText,
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload PDF"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 14, horizontal: 28),
                backgroundColor: isDark
                    ? Colors.purpleAccent[100]
                    : Colors.deepPurple,
                foregroundColor:
                isDark ? Colors.black : Colors.white,
                textStyle: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
