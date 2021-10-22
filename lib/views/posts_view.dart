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
          onPressed: () async {
            //navigate to add post
            bool refresh = await Get.to<bool>(() => AddPostView()) ?? false;
            if (refresh) {
              await _postController.getPosts();
            }
          },
        ),
        body: RefreshIndicator(
          onRefresh: () async => await _postController.getPosts(),
          child: Obx(() => _postController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _postController.posts.isEmpty
                  ? ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Something went wrong, no posts were loaded'),
                          ],
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: _postController.posts.length,
                      itemBuilder: (context, i) => Card(
                            elevation: 3,
                            child: ListTile(
                              onLongPress: () => _postController
                                  .showDialog(_postController.posts[i]),
                              title: Text(_postController.posts[i].title),
                              subtitle: Text(_postController.posts[i].body),
                            ),
                          ))),
        ));
  }
}
