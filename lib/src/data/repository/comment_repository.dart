import 'package:post_app/src/data/datasource/remote/comment_remote_data_source.dart';
import 'package:post_app/src/data/mapper/impl/comment_mapper.dart';
import 'package:post_app/src/domain/entity/comment.dart';
import 'package:post_app/src/domain/repository/i_comment_repository.dart';

class CommentRepository implements ICommentRepository {
  final CommentRemoteDataSource remoteDataSource;
  final CommentMapper mapper;

  CommentRepository({
    required this.remoteDataSource,
    required this.mapper,
  });

  @override
  Future<List<Comment>> fetchCommentsByPostId(int postId) async {
    final commentDTOs = await remoteDataSource.fetchComments(postId);
    return commentDTOs.map((dto) => mapper.toEntity(dto)).toList();
  }
}
