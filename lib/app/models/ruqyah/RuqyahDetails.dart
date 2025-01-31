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

 factory RuqyahDetails.fromJson(Map<String, dynamic> json) => RuqyahDetails(
       source: json['Source'],
       catId: json['cat_id'] is int ? json['cat_id'] : int.parse(json['cat_id'].toString()),
       id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
       ruqyaDetails: json['ruqya_details'],
       subcatId: json['subcat_id'] is int ? json['subcat_id'] : int.parse(json['subcat_id'].toString()),
       topicId: json['topic_id'] == null ? null : (json['topic_id'] is int ? json['topic_id'] : int.parse(json['topic_id'].toString())),
       topicName: json['topic_name'],
     );

 Map<String, dynamic> toJson() => {
       'Source': source,
       'cat_id': catId,
       'id': id,
       'ruqya_details': ruqyaDetails,
       'subcat_id': subcatId,
       'topic_id': topicId,
       'topic_name': topicName,
     };
}