class ExtractedDataModel {
  final String summary;
  final List<String> keywords;

  const ExtractedDataModel({
    required this.summary,
    required this.keywords,
  });

  ExtractedDataModel copyWith({
    String? summary,
    List<String>? keywords,
  }) {
    return ExtractedDataModel(
      summary: summary ?? this.summary,
      keywords: keywords ?? this.keywords,
    );
  }

  factory ExtractedDataModel.fromJson(Map<String, dynamic> json) {
    return ExtractedDataModel(
      summary: json['summary'] ?? '',
      keywords: List<String>.from(json['keywords'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary,
      'keywords': keywords,
    };
  }

  @override
  String toString() =>
      'Summary: $summary\nKeywords: ${keywords.join(', ')}';
}
