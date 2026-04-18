class Quote {
  final String quote;
  final String author;
  final List<String> categories;
  Quote({required this.quote, required this.author, required this.categories});
  // Factory constructor to create a Quote object from JSON
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      quote: json['quote'] ?? '',
      author: json['author'] ?? '',
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [],
    );
  }
  // Method to convert Quote object back to JSON
  Map<String, dynamic> toJson() {
    return {'quote': quote, 'author': author, 'categories': categories};
  }
}
