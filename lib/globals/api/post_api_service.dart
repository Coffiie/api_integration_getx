import 'package:api_integration/globals/constants/api_constants.dart';
import 'package:api_integration/globals/models/post.dart';
import 'package:dio/dio.dart';

class PostApiService {
  late Dio _dio;
  PostApiService() {
    _dio = Dio();
  }

  List<Post> _parsePosts(List data) {
    List<Post> posts = [];
    for (int i = 0; i < data.length; i++) {
      posts.add(Post.fromJson((data[i])));
    }
    return posts;
  }

  Future<List<Post>> getPosts() async {
    try {
      Response<List> response = await _dio.get('${ApiConstants.baseUrl}posts');
      if (response.data != null) {
        return _parsePosts(response.data!);
      } else {
        return [];
      }
    } catch (e) {
      print('[PostApiService - getPosts() Error] $e');
      return [];
    }
  }

  Future<bool> addPost(Post post) async {
    try {
      Response response =
          await _dio.post('${ApiConstants.baseUrl}posts', data: post.toJson());
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('[PostApiService - addPost() Error] $e');
      return false;
    }
  }
}
