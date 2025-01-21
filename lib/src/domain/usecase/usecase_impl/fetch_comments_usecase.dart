import 'package:post_app/src/data/repository/comment_repository.dart';
import 'package:post_app/src/domain/entity/comment.dart';

class FetchCommentsByPostIdUseCase{
  final CommentRepository repository;

  FetchCommentsByPostIdUseCase(this.repository);

  Future<List<Comment>> execute (int postId){
    return repository.fetchCommentsByPostId(postId);
  }
}