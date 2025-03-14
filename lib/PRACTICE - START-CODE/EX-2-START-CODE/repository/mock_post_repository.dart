import '../model/post.dart';

import 'post_repository.dart';

class MockPostRepository extends PostRepository {
  @override
  Future<Post> getPost(int postId) {
    return Future.delayed(Duration(seconds: 5), () {
      if (postId != 25) {
        throw Exception("No post found");
      }
      return Post(
        id: 25,
        title: 'Who is the best',
        description: 'teacher ronan',
      );
    });
  }

  @override
  Future<List<Post>> getPosts() {
    return Future.delayed(Duration(seconds: 5), () {
      return [
        // Post(
        //   id: 1,
        //   title: 'Post 1',
        //   description: 'Description for post 1',
        // ),
        // Post(
        //   id: 2,
        //   title: 'Post 2',
        //   description: 'Description for post 2',
        // ),
        // Post(
        //   id: 3,
        //   title: 'Post 3',
        //   description: 'Description for post 3',
        // ),
      ];
    });
  }
}
