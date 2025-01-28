class SalahTopic {
  final int id;
  final int category;
  final int titleId;
  final String description;
  final String reference;

  SalahTopic({
    required this.id,
    required this.category,
    required this.titleId,
    required this.description,
    required this.reference,
  });

  // Factory constructor for creating a SalahTopic instance from JSON
  factory SalahTopic.fromJson(Map<String, dynamic> json) {
    return SalahTopic(
      id: json['id'],
      category: json['category'],
      titleId: json['title_id'],
      description: json['description'] ?? '',
      reference: json['reference'] ?? '',
    );
  }

  // Method for converting a SalahTopic instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title_id': titleId,
      'description': description,
      'reference': reference,
    };
  }
}
