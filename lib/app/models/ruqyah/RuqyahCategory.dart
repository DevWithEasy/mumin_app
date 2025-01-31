class RuqyahCategory {
  final String catIcon;
  final int catId;
  final String categoryName;

  RuqyahCategory({
    required this.catIcon,
    required this.catId,
    required this.categoryName,
  });

  factory RuqyahCategory.fromJson(Map<String, dynamic> json) {
    return RuqyahCategory(
      catIcon: json['cat_icon'],
      catId: json['cat_id'],
      categoryName: json['category_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_icon': catIcon,
      'cat_id': catId,
      'category_name': categoryName,
    };
  }
}