import 'package:api_integration/globals/models/post.dart';
import 'package:api_integration/globals/repository/post_repository.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  RxList<Post> posts = RxList<Post>();
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    await getPosts();
    super.onInit();
  }

  Future<void> getPosts() async {
    PostRepository postRepository = PostRepository();
    isLoading(true);
    posts.value = await postRepository.getPosts();
    isLoading(false);
  }
}
