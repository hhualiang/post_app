import 'package:post_app/src/data/dtos/comment_dto.dart';
import 'package:post_app/src/data/mapper/interface/mapper.dart';
import 'package:post_app/src/domain/entity/comment.dart';

class CommentMapper extends Mapper<CommentDTO, Comment> {
  @override
  Comment toEntity(CommentDTO dto) {
    return Comment(
      postId: dto.postId,
      id: dto.id,
      name: dto.name,
      email: dto.email,
      body: dto.body,
    );
  }
}
