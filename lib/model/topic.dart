import 'dart:convert';

List<Topic> listTopicFromJson(String response) {
  final jsonData = json.decode(response);
  final data = jsonData["data"];
  return new List<Topic>.from(data.map((x) => Topic.fromJson(x)));
}

class Topic {
  int id;
  String topic_name;
  String cover;

  Topic({this.id, this.topic_name, this.cover});

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
      cover: json["cover"], id: json["id"], topic_name: json["name"]);

}
