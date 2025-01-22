// ignore: file_names
class Validity {
  Validity({
    required this.id,
    required this.background,
    required this.color,
    required this.description,
    required this.validityId,
    required this.sortOrder,
    required this.superTypeId,
    required this.title,
  });

  final String? id;
  final String? background;
  final String? color;
  final String? description;
  final int? validityId;
  final int? sortOrder;
  final String? superTypeId;
  final String? title;

  factory Validity.fromJson(Map<String, dynamic> json) {
    return Validity(
      id: json["_id"],
      background: json["background"],
      color: json["color"],
      description: json["description"],
      validityId: json["id"],
      sortOrder: json["sort_order"],
      superTypeId: json["superType_id"],
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "background": background,
        "color": color,
        "description": description,
        "id": validityId,
        "sort_order": sortOrder,
        "superType_id": superTypeId,
        "title": title,
      };
}
