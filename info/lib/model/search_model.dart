class SearchResult {
  final String title;
  final String url;
  final String description;

  SearchResult({
    required this.title,
    required this.url,
    required this.description,
  });

  factory SearchResult.fromJson(Map json) {
    return SearchResult(
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      description: json['description'] ?? '',
    );
  }
}