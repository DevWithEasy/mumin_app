class RuqyahDetails {
  final String? source;
  final int catId;
  final int id;
  final String ruqyaDetails;
  final int subcatId;
  final int? topicId;
  final String? topicName;

  RuqyahDetails({
    this.source,
    required this.catId,
    required this.id,
    required this.ruqyaDetails,
    required this.subcatId,
    this.topicId,
    this.topicName,
  });

  factory RuqyahDetails.fromJson(Map<String, dynamic> json) {
    return RuqyahDetails(
      source: json['Source'],
      catId: json['cat_id'],
      id: json['id'],
      ruqyaDetails: json['ruqya_details'],
      subcatId: json['subcat_id'],
      topicId: json['topic_id'],
      topicName: json['topic_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Source': source,
      'cat_id': catId,
      'id': id,
      'ruqya_details': ruqyaDetails,
      'subcat_id': subcatId,
      'topic_id': topicId,
      'topic_name': topicName,
    };
  }
}
