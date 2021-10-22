import 'package:api_integration/globals/api/post_api_service.dart';
import 'package:api_integration/globals/models/post.dart';

class PostRepository {
  late PostApiService _postApiService;
  PostRepository() {
    _postApiService = PostApiService();
  }

  Future<List<Post>> getPosts() async {
    List<Post> posts = await _postApiService.getPosts();
    return posts;
  }

  Future<bool> addPost(Post post) async {
    bool success = await _postApiService.addPost(post);
    return success;
  }
}
