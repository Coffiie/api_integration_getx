import 'package:api_integration/globals/constants/api_constants.dart';
import 'package:api_integration/globals/models/post.dart';
import 'package:dio/dio.dart';

class PostRepository {
  Future<List<Post>> getPosts() async {
    Dio dio = Dio();
    Response<List> response = await dio.get(ApiConstants.baseUrl + 'posts');
    if (response.data != null) {
      return _parsePosts(response.data!);
    }
    else
    {
      return [];
    }
  }

  List<Post> _parsePosts(List data) {
    List<Post> posts = [];
    for (int i = 0; i < data.length; i++) {
      posts.add(Post.fromJson((data[i])));
    }
    return posts;
  }
}
