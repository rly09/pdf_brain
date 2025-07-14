class TextAnalyzer {
  /// Summarizes [text] by returning top [maxSentences] sentences based on length and order.
  static String summarize(String text, {int? maxSentences}) {
    final sentences = text
        .split(RegExp(r'(?<=[.!?])\s+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (sentences.isEmpty) return "No summary available.";

    int takeCount = maxSentences ?? (sentences.length / 3).ceil();
    return sentences.take(takeCount).join(" ");
  }

  /// Extracts up to [maxKeywords] from [text] based on word frequency.
  static List<String> extractKeywords(String text, {int maxKeywords = 5}) {
    final cleanedText = text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), ' ')
        .split(RegExp(r'\s+'))
        .where((word) =>
    !_stopWords.contains(word) && word.trim().length > 3)
        .toList();

    final Map<String, int> frequencyMap = {};
    for (final word in cleanedText) {
      frequencyMap[word] = (frequencyMap[word] ?? 0) + 1;
    }

    final sorted = frequencyMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted.take(maxKeywords).map((e) => e.key).toList();
  }

  static const Set<String> _stopWords = {
    'the', 'and', 'that', 'have', 'for', 'not', 'with', 'you', 'this', 'but',
    'his', 'from', 'they', 'she', 'which', 'would', 'there', 'their', 'what',
    'about', 'could', 'your', 'than', 'then', 'them', 'were', 'just', 'some',
    'can', 'into', 'more', 'only', 'other', 'also', 'any', 'very', 'when', 'who',
    'are', 'was', 'our', 'been', 'such', 'where', 'will', 'how', 'shall', 'must'
  };
}
