import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../local_ai_service.dart';
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
        withData: true,
      );

      if (result == null || result.files.first.bytes == null) {
        setState(() => isLoading = false);
        return;
      }

      Uint8List fileBytes = result.files.first.bytes!;
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

      final summaryPoints =
      LocalAIService.summarize(extractedText, maxSentences: 5)
          .split('. ')
          .map((s) => s.trim() + '.')
          .where((s) => s.length > 30)
          .toList();

      final keywords = LocalAIService.extractKeywords(extractedText);

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Brain'),
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.picture_as_pdf_rounded,
              size: 90,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                "Upload a PDF to generate offline AI-powered summaries and extract key terms.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: pickAndExtractText,
              icon: const Icon(Icons.upload_file,color: Colors.white,),
              label: const Text("Upload PDF"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 14, horizontal: 28),
                textStyle: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
