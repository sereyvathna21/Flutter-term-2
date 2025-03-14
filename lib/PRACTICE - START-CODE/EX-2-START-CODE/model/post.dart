class Post {
  final int id;
  final String title;
  final String description;

  Post({required this.id, required this.title, required this.description});

  factory Post.fromJson(Map<String, dynamic> json) {
    assert(json['id'] is int, 'ID is not an integer');
    assert(json['title'] is String, 'Title is not a string');
    assert(json['body'] is String, 'Body is not a string');

    return Post(
      id: json['id'],
      title: json['title'],
      description: json['body'], // Assuming 'body' is the description
    );
  }
}
