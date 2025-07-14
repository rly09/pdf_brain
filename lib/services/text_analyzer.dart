class TextAnalyzer {
  static String summarize(String text) {
    final sentences = text.split(RegExp(r'[.!?]')).where((s) => s.trim().isNotEmpty).toList();
    if (sentences.isEmpty) return "No summary available.";
    int take = (sentences.length / 3).ceil();
    return sentences.take(take).join(". ") + ".";
  }

  static List<String> extractKeywords(String text) {
    final words = text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .split(RegExp(r'\s+'))
        .where((word) => !_stopWords.contains(word) && word.length > 3)
        .toList();

    final Map<String, int> freq = {};
    for (var word in words) {
      freq[word] = (freq[word] ?? 0) + 1;
    }

    final sortedWords = freq.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedWords.take(5).map((e) => e.key).toList();
  }

  static const List<String> _stopWords = [
    'the', 'and', 'that', 'have', 'for', 'not', 'with', 'you', 'this', 'but',
    'his', 'from', 'they', 'she', 'which', 'would', 'there', 'their', 'what',
    'about', 'could', 'your', 'than', 'then', 'them', 'were', 'just', 'some',
    'can', 'into', 'more', 'only', 'other', 'also', 'any', 'very', 'when', 'who'
  ];
}
