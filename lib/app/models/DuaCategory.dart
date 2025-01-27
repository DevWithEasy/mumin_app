class DuaCategory {
  final int id;
  final String name;
  final String image;

  DuaCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory DuaCategory.fromJson(Map<String, dynamic> json) {
    return DuaCategory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
