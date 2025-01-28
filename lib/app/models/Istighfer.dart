class Istighfer {
  final int id;
  final String name;
  final String info;
  final String arabic;
  final String bangla;
  final String translation;
  final String benifits;
  final String reference;

  Istighfer({
    required this.id,
    required this.name,
    required this.info,
    required this.arabic,
    required this.bangla,
    required this.translation,
    required this.benifits,
    required this.reference,
  });

  // Factory method to create a Istighfer object from JSON
  factory Istighfer.fromJson(Map<String, dynamic> json) {
    return Istighfer(
      id: json['id'],
      name: json['name'],
      info: json['info'],
      arabic: json['arabic'],
      bangla: json['bangla'],
      translation: json['translation'],
      benifits: json['benifits'],
      reference: json['reference'],
    );
  }

  // Method to convert a Istighfer object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'info': info,
      'arabic': arabic,
      'bangla': bangla,
      'translation': translation,
      'benifits': benifits,
      'reference': reference,
    };
  }
}
