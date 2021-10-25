import 'package:api_integration/globals/constants/api_constants.dart';
import 'package:api_integration/globals/models/post.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PostApiService {
  late Dio _dio;
  PostApiService() {
    _dio = Dio(BaseOptions(
        headers: {'Content-type': 'application/json; charset=UTF-8'}));
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
      if (kDebugMode) {
        print('[PostApiService - getPosts() Error] $e');
      }
      return [];
    }
  }

  Future<bool> addPost(Post post) async {
    try {
      Response response =
          await _dio.post('${ApiConstants.baseUrl}posts', data: post.toJson());
      if (response.data != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('[PostApiService - addPost() Error] $e');
      }
      return false;
    }
  }

  Future<bool> deletePost(Post post) async {
    try {
      Response response =
          await _dio.delete('${ApiConstants.baseUrl}posts/${post.id}');
      if (response.data != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('[PostApiService - deletePost() Error] $e');
      }
      return false;
    }
  }

  Future<bool> updatePost(Post post) async {
    try {
      Response response = await _dio
          .put('${ApiConstants.baseUrl}posts/${post.id}', data: post.toJson());
      if (response.data != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('[PostApiService - updatePost() Error] $e');
      }
      return false;
    }
  }
}
