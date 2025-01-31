class RuqyahSubCategory {
  final int catId;
  final int subcatId;
  final String subcatName;

  RuqyahSubCategory({
    required this.catId,
    required this.subcatId,
    required this.subcatName,
  });

  factory RuqyahSubCategory.fromJson(Map<String, dynamic> json) {
    return RuqyahSubCategory(
      catId: json['cat_id'],
      subcatId: json['subcat_id'],
      subcatName: json['subcat_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_id': catId,
      'subcat_id': subcatId,
      'subcat_name': subcatName,
    };
  }
}
