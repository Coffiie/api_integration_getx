import 'package:api_integration/controllers/post_controller.dart';
import 'package:api_integration/globals/models/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrUpdatePostView extends StatelessWidget {
  AddOrUpdatePostView({Key? key, required this.isUpdate, this.post})
      : super(key: key);

  late final Post? post;
  late final bool isUpdate;
  final PostController _postController = Get.find<PostController>();
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      _titleTextController.text = post!.title;
      _descriptionTextController.text = post!.body;
    }
    _postController.isSaveButtonEnabled.value = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Update Post' : 'Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextFormField(
              onChanged: (String val) {
                isUpdate
                    ? _postController.validatePost(
                        val, _descriptionTextController.text, post!)
                    : _postController.validate(
                        val, _descriptionTextController.text);
              },
              controller: _titleTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add Post Title')),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            onChanged: (String val) {
              isUpdate
                  ? _postController.validatePost(
                      _titleTextController.text, val, post!)
                  : _postController.validate(_titleTextController.text, val);
            },
            controller: _descriptionTextController,
            maxLines: 5,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Add Post Description'),
          ),
          const Spacer(),
          Row(
            children: [
              Obx(
                () => Expanded(
                    child: ElevatedButton(
                        onPressed: _postController.isSaveButtonEnabled.value
                            ? () async {
                                await _postController.handleSave(
                                    _titleTextController.text,
                                    _descriptionTextController.text,
                                    context,
                                    isUpdate,
                                    post: post);
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _postController.isButtonLoading.value
                              ? const CircularProgressIndicator()
                              : Text(
                                  isUpdate ? 'Update' : 'Save',
                                  style: const TextStyle(fontSize: 16),
                                ),
                        ))),
              )
            ],
          )
        ]),
      ),
    );
  }
}
