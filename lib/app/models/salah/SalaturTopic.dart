class SalaturTopic {
  final int id;
  final int category;
  final int titleId;
  final String description;
  final String reference;

  SalaturTopic({
    required this.id,
    required this.category,
    required this.titleId,
    required this.description,
    required this.reference,
  });

  // Factory constructor for creating a SalaturTopic instance from JSON
  factory SalaturTopic.fromJson(Map<String, dynamic> json) {
    return SalaturTopic(
      id: json['id'],
      category: json['category'],
      titleId: json['title_id'],
      description: json['description'] ?? '',
      reference: json['reference'] ?? '',
    );
  }

  // Method for converting a SalaturTopic instance to JSON
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
