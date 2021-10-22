import 'package:api_integration/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostView extends StatelessWidget {
  AddPostView({Key? key}) : super(key: key);

  final PostController _postController = Get.find<PostController>();
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _postController.isSaveButtonEnabled.value = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextFormField(
              onChanged: (String val) {
                _postController.validate(val, _descriptionTextController.text);
              },
              controller: _titleTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add Post Title')),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            onChanged: (String val) {
              _postController.validate(_descriptionTextController.text, val);
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
                                    context);
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _postController.isButtonLoading.value
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Save',
                                  style: TextStyle(fontSize: 16),
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
