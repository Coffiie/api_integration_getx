import 'package:api_integration/globals/models/post.dart';
import 'package:api_integration/globals/repository/post_repository.dart';
import 'package:api_integration/globals/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  late PostRepository _postRepository;

  RxList<Post> posts = RxList<Post>();
  RxBool isLoading = false.obs;
  RxBool isSaveButtonEnabled = false.obs;
  RxString titleError = ''.obs;
  RxString descriptionError = ''.obs;
  RxBool isButtonLoading = false.obs;

  @override
  Future<void> onInit() async {
    _postRepository = PostRepository();
    await getPosts();
    super.onInit();
  }

  Future<void> getPosts() async {
    isLoading(true);
    posts.value = await _postRepository.getPosts();
    isLoading(false);
  }

  Future<void> handleSave(
      String title, String description, BuildContext context) async {
    bool success = validate(title, description);
    if (success) {
      //call api
      isButtonLoading(true);
      isSaveButtonEnabled(false);
      bool postAdded = await _postRepository
          .addPost(Post(title: title, body: description, userId: 1));
      isButtonLoading(false);
      isSaveButtonEnabled(true);
      if (postAdded) {
        UiUtils.clearKeyboardFocus(context);
        Get.back<bool>(result: true);
        Get.snackbar('Yippie', 'Post saved',
            duration: const Duration(seconds: 3));
      } else {
        Get.snackbar('Woops', 'Due to some reason, post was not saved',
            duration: const Duration(seconds: 5));
      }
    }
  }

  bool validate(String title, String description) {
    bool success = true;
    if (title.isEmpty) {
      // titleError.value = 'Title is Empty';
      success = false;
    }
    if (description.isEmpty) {
      // descriptionError.value = 'Description is Empty';
      success = false;
    }
    isSaveButtonEnabled.value = success ? true : false;
    return success;
  }

  void showDialog(Post post) =>
      UiUtils.showDialog(() async => await _handleDelete(post));

  Future<void> _handleDelete(Post post) async {
    Get.back();
    isLoading(true);
    bool hasPostDeleted = await _postRepository.deletePost(post);
    if (hasPostDeleted) {
      Get.snackbar('Yippie', 'Post Deleted',
          duration: const Duration(seconds: 3));
    } else {
      Get.snackbar('Woops', 'Due to some reason, post was not saved',
          duration: const Duration(seconds: 5));
    }
    isLoading(false);
  }
}
