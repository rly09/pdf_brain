class LocalAIService {
  /// Summarizes the input [text] by extracting the first [maxSentences] sentences.
  static String summarize(String text, {int maxSentences = 3}) {
    final sentences = text.split(RegExp(r'(?<=[.?!])\s+'));
    if (sentences.length <= maxSentences) return text;

    return sentences.take(maxSentences).join(' ');
  }

  /// Extracts up to [maxKeywords] from the input [text] based on word frequency.
  static List<String> extractKeywords(String text, {int maxKeywords = 5}) {
    final cleanedText = text.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');
    final words = cleanedText
        .split(RegExp(r'\s+'))
        .where((word) => word.length > 4 && !_stopWords.contains(word))
        .toList();

    final freqMap = <String, int>{};
    for (var word in words) {
      freqMap[word] = (freqMap[word] ?? 0) + 1;
    }

    final sorted = freqMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted.take(maxKeywords).map((e) => e.key).toList();
  }

  static final Set<String> _stopWords = {
    'about', 'above', 'after', 'again', 'against', 'all', 'am', 'are', 'as',
    'at', 'be', 'because', 'been', 'before', 'being', 'below', 'between',
    'both', 'but', 'by', 'could', 'did', 'do', 'does', 'doing', 'down', 'during',
    'each', 'few', 'for', 'from', 'further', 'had', 'has', 'have', 'having',
    'he', 'her', 'here', 'hers', 'him', 'himself', 'his', 'how', 'i', 'if', 'in',
    'into', 'is', 'it', 'its', 'itself', 'just', 'me', 'more', 'most', 'my',
    'myself', 'no', 'nor', 'not', 'now', 'of', 'off', 'on', 'once', 'only',
    'or', 'other', 'our', 'ours', 'ourselves', 'out', 'over', 'own', 'same',
    'she', 'should', 'so', 'some', 'such', 'than', 'that', 'the', 'their',
    'theirs', 'them', 'themselves', 'then', 'there', 'these', 'they', 'this',
    'those', 'through', 'to', 'too', 'under', 'until', 'up', 'very', 'was',
    'we', 'were', 'what', 'when', 'where', 'which', 'while', 'who', 'whom',
    'why', 'with', 'would', 'you', 'your', 'yours', 'yourself', 'yourselves'
  };
}
