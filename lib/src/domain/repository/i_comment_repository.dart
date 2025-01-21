import 'package:post_app/src/domain/entity/comment.dart';

abstract class ICommentRepository {
  Future<List<Comment>> fetchCommentsByPostId(int postId);
}
