import 'package:post_app/src/domain/entity/post.dart';
import 'package:post_app/src/domain/usecase/usecase_interface/i_use_case.dart';

class PostController {
  final IFetchPostsUseCase useCase;

  PostController(
    this.useCase,
  );

  Future<List<Post>> getPosts() async {
    return await useCase.execute();
  }
}
