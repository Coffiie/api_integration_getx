import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiUtils {
  static void clearKeyboardFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static showDialog(Function() onConfirm) {
    Get.defaultDialog(
        title: 'Are you sure?',
        content: const Text('Delete this post?'),
        textConfirm: 'Delete',
        confirmTextColor: Colors.white,
        onConfirm: onConfirm,
        onCancel: () => Get.back());
  }
}
