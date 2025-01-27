class Dua {
  final int id;
  final int category;
  final String name;
  final String arabic;
  final String bottom;
  final String reference;
  final String top;
  final String translations;

  Dua({
    required this.id,
    required this.category,
    required this.name,
    required this.arabic,
    required this.bottom,
    required this.reference,
    required this.top,
    required this.translations,
  });

  factory Dua.fromJson(Map<String, dynamic> json) {
    return Dua(
      id: json['id'],
      category: json['category'],
      name: json['name'],
      arabic: json['arabic'],
      bottom: json['bottom'] ?? '', // Default to empty string if null
      reference: json['reference'] ?? '',
      top: json['top'] ?? '',
      translations: json['translations'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'arabic': arabic,
      'bottom': bottom,
      'reference': reference,
      'top': top,
      'translations': translations,
    };
  }
}