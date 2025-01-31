class Mahram {
  final String gender;
  final String image;
  final List<MahramItem> list;

  Mahram({
    required this.gender,
    required this.image,
    required this.list,
  });

  factory Mahram.fromJson(Map<String, dynamic> json) {
    return Mahram(
      gender: json['gender'],
      image: json['image'],
      list: (json['list'] as List)
          .map((item) => MahramItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'image': image,
      'list': list.map((item) => item.toJson()).toList(),
    };
  }
}

class MahramItem {
  final String name;
  final bool isMarham;

  MahramItem({
    required this.name,
    required this.isMarham,
  });

  factory MahramItem.fromJson(Map<String, dynamic> json) {
    return MahramItem(
      name: json['name'],
      isMarham: json['isMarham'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isMarham': isMarham,
    };
  }
}
