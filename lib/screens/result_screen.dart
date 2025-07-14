import 'dart:io';
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

  List<String> get cleanedSummary {
    return widget.summaryPoints
        .map((e) => e
        .replaceAll('•', '')
        .replaceAll('\n', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim())
        .where((e) => e.isNotEmpty)
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

    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/summary.pdf');
    await file.writeAsBytes(bytes, flush: true);
    pdf.dispose();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved as summary.pdf')),
    );
  }

  Future<void> _shareSummary() async {
    final text = cleanedSummary.map((e) => '• $e').join('\n');
    await Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filtered = selectedKeywords.isEmpty
        ? cleanedSummary
        : cleanedSummary
        .where((point) => selectedKeywords.any(
            (k) => point.toLowerCase().contains(k.toLowerCase())))
        .toList();

    final filteredKeywords = widget.keywords
        .map((k) => k.trim())
        .where((k) => k.isNotEmpty)
        .toSet()
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("📄 Summary Insights"),
        backgroundColor: isDark ? Colors.deepPurple[300] : Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "💡 Filter by Keywords",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            filteredKeywords.isEmpty
                ? const Text(
              "No keywords found.",
              style: TextStyle(color: Colors.grey),
            )
                : Wrap(
              spacing: 8,
              children: filteredKeywords.map((keyword) {
                final selected = selectedKeywords.contains(keyword);
                return FilterChip(
                  label: Text(keyword),
                  selected: selected,
                  selectedColor: isDark
                      ? Colors.deepPurple[200]
                      : Colors.deepPurple[100],
                  onSelected: (bool value) {
                    setState(() {
                      selected
                          ? selectedKeywords.remove(keyword)
                          : selectedKeywords.add(keyword);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "📌 Summary",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text("No summary points to show."))
                  : ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (_, index) => ListTile(
                  leading: const Text("•",
                      style: TextStyle(fontSize: 20)),
                  title: Text(filtered[index]),
                ),
              ),
            ),
            const Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("Save PDF"),
                    onPressed: _saveAsPdf,
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.share),
                    label: const Text("Share"),
                    onPressed: _shareSummary,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
