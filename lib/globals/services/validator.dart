import 'package:api_integration/globals/models/post.dart';

class Validator {
  static bool validate(String title, String description) {
    bool success = true;
    if (title.isEmpty) {
      success = false;
    }
    if (description.isEmpty) {
      success = false;
    }
    return success;
  }

  static bool validatePost(String title, String description, Post post) {
    bool success = true;
    if (post.title != title || post.body != description) {
      success = true;
    } else {
      success = false;
    }
    if (title.isEmpty) {
      success = false;
    }
    if (description.isEmpty) {
      success = false;
    }
    return success;
  }
}
