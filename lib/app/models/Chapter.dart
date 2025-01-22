class Chapter {
    Chapter({
        required this.id,
        required this.bookId,
        required this.bookName,
        required this.chapterChapterId,
        required this.hadisRange,
        required this.chapterId,
        required this.number,
        required this.title,
    });

    final String? id;
    final int? bookId;
    final String? bookName;
    final int? chapterChapterId;
    final String? hadisRange;
    final int? chapterId;
    final int? number;
    final String? title;

    factory Chapter.fromJson(Map<String, dynamic> json){ 
        return Chapter(
            id: json["_id"],
            bookId: json["book_id"],
            bookName: json["book_name"],
            chapterChapterId: json["chapter_id"],
            hadisRange: json["hadis_range"],
            chapterId: json["id"],
            number: json["number"],
            title: json["title"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "book_id": bookId,
        "book_name": bookName,
        "chapter_id": chapterChapterId,
        "hadis_range": hadisRange,
        "id": chapterId,
        "number": number,
        "title": title,
    };

}