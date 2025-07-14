import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ResultScreen extends StatefulWidget {
  final List<String> summaryPoints;
  final List<String> keywords;

  const ResultScreen({
    super.key,
    required this.summaryPoints,
    required this.keywords,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<String> selectedKeywords = [];

  List<String> get cleanedSummary => widget.summaryPoints
      .map((e) => e.replaceAll('•', '').replaceAll('\n', ' ').trim())
      .where((e) => e.isNotEmpty)
      .toList();

  List<String> get filteredSummary {
    if (selectedKeywords.isEmpty) return cleanedSummary;
    return cleanedSummary
        .where((point) => selectedKeywords.any(
            (k) => point.toLowerCase().contains(k.toLowerCase())))
        .toList();
  }

  Future<void> _saveAsPdf() async {
    final pdf = PdfDocument();
    final page = pdf.pages.add();

    final text = cleanedSummary.map((e) => '• $e').join('\n');

    page.graphics.drawString(
      text,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
    );

    final List<int> bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/summary.pdf');
    await file.writeAsBytes(bytes, flush: true);
    pdf.dispose();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Summary saved as summary.pdf')),
      );
    }
  }

  Future<void> _shareSummary() async {
    final text = cleanedSummary.map((e) => '• $e').join('\n');
    await Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final filteredKeywords = widget.keywords
        .map((k) => k.trim())
        .where((k) => k.isNotEmpty)
        .toSet()
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("📄 Summary Insights"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "💡 Filter by Keywords",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            filteredKeywords.isEmpty
                ? const Text("No keywords found.",
                style: TextStyle(color: Colors.grey))
                : Wrap(
              spacing: 8,
              runSpacing: 4,
              children: filteredKeywords.map((keyword) {
                final isSelected = selectedKeywords.contains(keyword);
                return FilterChip(
                  label: Text(keyword),
                  selected: isSelected,
                  selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                  onSelected: (value) {
                    setState(() {
                      isSelected
                          ? selectedKeywords.remove(keyword)
                          : selectedKeywords.add(keyword);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "📌 Summary Points",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredSummary.isEmpty
                  ? const Center(child: Text("No summary points to display."))
                  : ListView.separated(
                itemCount: filteredSummary.length,
                separatorBuilder: (_, __) =>
                const Divider(height: 8, thickness: 0.5),
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("• ",
                            style: TextStyle(fontSize: 18)),
                        Expanded(
                          child: Text(
                            filteredSummary[index],
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.picture_as_pdf_rounded,color: Colors.white,),
                  label: const Text("Save as PDF"),
                  onPressed: _saveAsPdf,
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.share_rounded,color: Colors.white,),
                  label: const Text("Share Summary"),
                  onPressed: _shareSummary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
