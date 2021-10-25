import 'package:api_integration/globals/api/post_api_service.dart';
import 'package:api_integration/globals/models/post.dart';

class PostRepository {
  late PostApiService _postApiService;
  PostRepository() {
    _postApiService = PostApiService();
  }

  Future<List<Post>> getPosts() async => await _postApiService.getPosts();

  Future<bool> addPost(Post post) async => await _postApiService.addPost(post);

  Future<bool> deletePost(Post post) async =>
      await _postApiService.deletePost(post);

  Future<bool> updatePost(Post post) async =>
      await _postApiService.updatePost(post);
}
