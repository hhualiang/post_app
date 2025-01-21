import 'package:post_app/src/data/dtos/post_dto.dart';
import 'package:post_app/src/data/mapper/interface/mapper.dart';
import 'package:post_app/src/domain/entity/post.dart';

class PostMapper extends Mapper<PostDTO, Post> {
  @override
  Post toEntity(PostDTO dto) {
    return Post(
      id: dto.id,
      title: dto.title,
      body: dto.body,
    );
  }
}
