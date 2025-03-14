import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/post.dart';
import 'post_repository.dart';

class HttpPostsRepository extends PostRepository {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  @override
  Future<Post> getPost(int postId) async {
    final response = await http.get(Uri.parse('$apiUrl/$postId'));

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
