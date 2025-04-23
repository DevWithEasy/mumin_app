class Kalima {
  final int id;
  final String title;
  final String explain;
  final String arabic;
  final String punctuation;
  final String translation;

  Kalima({
    required this.id,
    required this.title,
    required this.explain,
    required this.arabic,
    required this.punctuation,
    required this.translation,
  });

  // Factory method to create a Kalima object from JSON
  factory Kalima.fromJson(Map<String, dynamic> json) {
    return Kalima(
      id: json['id'],
      title: json['title'],
      explain: json['explain'],
      arabic: json['arabic'],
      punctuation: json['punctuation'],
      translation: json['translation'],
    );
  }

  // Method to convert a Kalima object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'explain': explain,
      'arabic': arabic,
      'punctuation': punctuation,
      'translation': translation,
    };
  }
}