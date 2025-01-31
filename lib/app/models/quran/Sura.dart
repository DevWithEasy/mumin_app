class Sura {
    Sura({
        required this.id,
        required this.name,
        required this.transliteration,
        required this.translation,
        required this.type,
        required this.totalVerses,
        required this.link,
    });

    final int? id;
    final String? name;
    final String? transliteration;
    final String? translation;
    final String? type;
    final int? totalVerses;
    final String? link;

    factory Sura.fromJson(Map<String, dynamic> json){ 
        return Sura(
            id: json["id"],
            name: json["name"],
            transliteration: json["transliteration"],
            translation: json["translation"],
            type: json["type"],
            totalVerses: json["total_verses"],
            link: json["link"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "transliteration": transliteration,
        "translation": translation,
        "type": type,
        "total_verses": totalVerses,
        "link": link,
    };

}