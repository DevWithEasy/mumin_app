class AllahName {
  final int id;
  final String arbi;
  final String bangla;
  final String meaning;
  final String faz;

  AllahName({
    required this.id,
    required this.arbi,
    required this.bangla,
    required this.meaning,
    required this.faz,
  });

  // Factory method to create an AllahName object from JSON
  factory AllahName.fromJson(Map<String, dynamic> json) {
    return AllahName(
      id: json['id'],
      arbi: json['arbi'],
      bangla: json['bangla'],
      meaning: json['meaning'],
      faz: json['faz'],
    );
  }

  // Method to convert an AllahName object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arbi': arbi,
      'bangla': bangla,
      'meaning': meaning,
      'faz': faz,
    };
  }
}