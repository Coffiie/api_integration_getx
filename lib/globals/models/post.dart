class Post {
  int? id;
  late String title;
  late String body;
  late int userId;

  Post(
      {this.id, required this.title, required this.body, required this.userId});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['userId'] = userId;
    return data;
  }
}
