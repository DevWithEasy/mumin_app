class SalahCategory {
  final int id;
  final String title;
  final String image;
  final List<Topic> topics;

  SalahCategory({
    required this.id,
    required this.title,
    required this.image,
    required this.topics,
  });

  factory SalahCategory.fromJson(Map<String, dynamic> json) {
    return SalahCategory(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      topics: (json['topics'] as List).map((topic) => Topic.fromJson(topic)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'topics': topics.map((topic) => topic.toJson()).toList(),
    };
  }
}

class Topic {
  final int id;
  final String title;
  final String image;

  Topic({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }
}