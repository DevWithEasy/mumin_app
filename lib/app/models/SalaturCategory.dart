class SalaturCategory {
  final int id;
  final String heading;
  final List<Topic> topics;

  SalaturCategory({
    required this.id,
    required this.heading,
    required this.topics,
  });

  // Factory method to create a SalaturCategory object from JSON
  factory SalaturCategory.fromJson(Map<String, dynamic> json) {
    return SalaturCategory(
      id: json['id'],
      heading: json['heading'],
      topics: (json['topics'] as List)
          .map((topic) => Topic.fromJson(topic))
          .toList(),
    );
  }

  // Method to convert a SalaturCategory object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'heading': heading,
      'topics': topics.map((topic) => topic.toJson()).toList(),
    };
  }
}

class Topic {
  final String id;
  final String title;

  Topic({
    required this.id,
    required this.title,
  });

  // Factory method to create a Topic object from JSON
  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      title: json['title'],
    );
  }

  // Method to convert a Topic object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}