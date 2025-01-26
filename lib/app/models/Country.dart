class Country {
  final String iso2;
  final String iso3;
  final String country;
  final List<String> cities;

  Country({
    required this.iso2,
    required this.iso3,
    required this.country,
    required this.cities,
  });

  // Factory constructor to create a Country object from JSON
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      iso2: json['iso2'],
      iso3: json['iso3'],
      country: json['country'],
      cities: List<String>.from(json['cities']),
    );
  }

  // Method to convert a Country object to JSON
  Map<String, dynamic> toJson() {
    return {
      'iso2': iso2,
      'iso3': iso3,
      'country': country,
      'cities': cities,
    };
  }
}
