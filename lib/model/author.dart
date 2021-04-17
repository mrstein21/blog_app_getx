class Author{
  int id;
  String name;
  String avatar;

  Author({
    this.id,
    this.name,
    this.avatar
  });

  factory Author.fromJson(Map<String,dynamic>json)=>Author(
      id: json["id"],
      name: json["name"],
      avatar: json["avatar"]
  );

}