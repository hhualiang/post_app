import 'package:post_app/src/domain/entity/comment.dart';
import 'package:post_app/src/domain/repository/i_comment_repository.dart';

abstract class FetchCommentsUseCase {
  Future<List<Comment>> execute(int postId);
}

class FetchCommentsUseCaseImpl implements FetchCommentsUseCase {
  final ICommentRepository repository;

  FetchCommentsUseCaseImpl(this.repository);

  @override
  Future<List<Comment>> execute(int postId) {
    return repository.fetchCommentsByPostId(postId);
  }
}
