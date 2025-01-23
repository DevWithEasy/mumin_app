class SuraDeatils {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<Ayah> ayahs;

  SuraDeatils({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.ayahs,
    required this.revelationType,
  });

  factory SuraDeatils.fromJson(Map<String, dynamic> json) {
    return SuraDeatils(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      revelationType: json['revelationType'],
      ayahs:
          (json['ayahs'] as List).map((ayah) => Ayah.fromJson(ayah)).toList(),
    );
  }
}

class Ayah {
  final int number;
  final int numberInSurah;
  final String arabic;
  final String english;
  final String muhiuddin_bn;
  final String jahirul_bn;

  Ayah({
    required this.number,
    required this.numberInSurah,
    required this.arabic,
    required this.english,
    required this.muhiuddin_bn,
    required this.jahirul_bn,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['number'],
      numberInSurah: json['numberInSurah'],
      arabic: json['arabic'],
      english: json['english'],
      muhiuddin_bn: json['muhiuddin_bn'],
      jahirul_bn: json['jahirul_bn'],
    );
  }
}
