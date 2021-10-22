import 'package:api_integration/controllers/post_controller.dart';
import 'package:api_integration/views/add_post_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsView extends StatelessWidget {
  PostsView({Key? key}) : super(key: key);

  final PostController _postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            //navigate to add post
            Get.to(const AddPostView());
          },
        ),
        body: Obx(() => _postController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _postController.posts.length,
                itemBuilder: (context, i) => Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(_postController.posts[i].title),
                        subtitle: Text(_postController.posts[i].body),
                      ),
                    ))));
  }
}
