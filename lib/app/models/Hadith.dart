class Hadith {
    Hadith({
        required this.id,
        required this.bookId,
        required this.bookName,
        required this.chapterId,
        required this.hadithId,
        required this.number,
        required this.preface,
        required this.sectionId,
        required this.sortOrder,
        required this.title,
        required this.hadiths,
    });

    final String? id;
    final int? bookId;
    final String? bookName;
    final int? chapterId;
    final int? hadithId;
    final String? number;
    final String? preface;
    final int? sectionId;
    final int? sortOrder;
    final String? title;
    final List<HadithElement> hadiths;

    factory Hadith.fromJson(Map<String, dynamic> json){ 
        return Hadith(
            id: json["_id"],
            bookId: json["book_id"],
            bookName: json["book_name"],
            chapterId: json["chapter_id"],
            hadithId: json["id"],
            number: json["number"],
            preface: json["preface"],
            sectionId: json["section_id"],
            sortOrder: json["sort_order"],
            title: json["title"],
            hadiths: json["hadiths"] == null ? [] : List<HadithElement>.from(json["hadiths"]!.map((x) => HadithElement.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "book_id": bookId,
        "book_name": bookName,
        "chapter_id": chapterId,
        "id": hadithId,
        "number": number,
        "preface": preface,
        "section_id": sectionId,
        "sort_order": sortOrder,
        "title": title,
        "hadiths": hadiths.map((x) => x.toJson()).toList(),
    };

}

class HadithElement {
    HadithElement({
        required this.id,
        required this.ar,
        required this.arDiacless,
        required this.bn,
        required this.bookId,
        required this.bookName,
        required this.chapterId,
        required this.grade,
        required this.gradeColor,
        required this.gradeId,
        required this.hadithHadithId,
        required this.hadithKey,
        required this.hadithId,
        required this.narrator,
        required this.note,
        required this.sectionId,
    });

    final String? id;
    final String? ar;
    final String? arDiacless;
    final String? bn;
    final int? bookId;
    final String? bookName;
    final int? chapterId;
    final String? grade;
    final String? gradeColor;
    final int? gradeId;
    final int? hadithHadithId;
    final String? hadithKey;
    final int? hadithId;
    final String? narrator;
    final String? note;
    final int? sectionId;

    factory HadithElement.fromJson(Map<String, dynamic> json){ 
        return HadithElement(
            id: json["_id"],
            ar: json["ar"],
            arDiacless: json["ar_diacless"],
            bn: json["bn"],
            bookId: json["book_id"],
            bookName: json["book_name"],
            chapterId: json["chapter_id"],
            grade: json["grade"],
            gradeColor: json["grade_color"],
            gradeId: json["grade_id"],
            hadithHadithId: json["hadith_id"],
            hadithKey: json["hadith_key"],
            hadithId: json["id"],
            narrator: json["narrator"],
            note: json["note"],
            sectionId: json["section_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "ar": ar,
        "ar_diacless": arDiacless,
        "bn": bn,
        "book_id": bookId,
        "book_name": bookName,
        "chapter_id": chapterId,
        "grade": grade,
        "grade_color": gradeColor,
        "grade_id": gradeId,
        "hadith_id": hadithHadithId,
        "hadith_key": hadithKey,
        "id": hadithId,
        "narrator": narrator,
        "note": note,
        "section_id": sectionId,
    };

}