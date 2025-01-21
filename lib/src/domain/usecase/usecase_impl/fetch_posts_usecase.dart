import 'package:post_app/src/data/core/error_handler.dart';
import 'package:post_app/src/domain/entity/post.dart';
import 'package:post_app/src/domain/repository/i_post_repository.dart';
import 'package:post_app/src/domain/usecase/usecase_interface/i_fetch_posts_usecase.dart';

class FetchPostsUseCaseImpl implements IFetchPostsUseCase {
  final IPostRepository repository;

  FetchPostsUseCaseImpl(this.repository);

  @override
  Future<List<Post>> execute() async {
    try {
      return await repository.fetchPosts();
    } catch (e) {
      throw handleError(e as Exception);
    }
  }
}
