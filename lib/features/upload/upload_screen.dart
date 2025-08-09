import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../screens/result_screen.dart';
import '../../services/gemini_service.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> pickAndExtractText() async {
    isLoading.value = true;

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );

      if (result == null || result.files.first.bytes == null) {
        showSnackBar('❗ No PDF selected');
        isLoading.value = false;
        return;
      }

      final Uint8List fileBytes = result.files.first.bytes!;
      final PdfDocument document = PdfDocument(inputBytes: fileBytes);
      final String extractedText = PdfTextExtractor(document).extractText();
      document.dispose();

      if (extractedText.trim().isEmpty) {
        showSnackBar('⚠️ No text found in the PDF');
        isLoading.value = false;
        return;
      }

      String summaryRaw = '';
      List<String> keywords = [];

      try {
        summaryRaw = await GeminiService.summarizeText(extractedText);
        keywords = await GeminiService.extractKeywords(extractedText);
      } catch (geminiError) {
        showSnackBar("⚠️ Gemini Error: ${geminiError.toString()}");
        isLoading.value = false;
        return;
      }

      final summaryPoints = summaryRaw
          .split(RegExp(r'[-•\n]'))
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty && s.length > 30)
          .toList();

      if (summaryPoints.isEmpty) {
        summaryPoints.add('⚠️ Gemini returned no meaningful summary.');
      }

      isLoading.value = false;

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
      showSnackBar("❌ Unexpected Error: ${e.toString()}");
      isLoading.value = false;
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Brain'),
        centerTitle: true,
      ),
      body: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, loading, _) {
            if (loading) {
              return const CircularProgressIndicator();
            }

            return Column(
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
                    "Upload a PDF to generate AI-powered summaries and extract key terms with Gemini.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: pickAndExtractText,
                  icon: const Icon(Icons.upload_file, color: Colors.white),
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
            );
          },
        ),
      ),
    );
  }
}
