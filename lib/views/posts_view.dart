import 'package:api_integration/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsView extends StatelessWidget {
  PostsView({Key? key}) : super(key: key);

  final PostController _postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => _postController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _postController.posts.length,
                itemBuilder: (context, i) => ListTile(
                      title: Text(_postController.posts[i].title),
                    ))));
  }
}
