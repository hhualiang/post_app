import 'package:post_app/src/data/core/error_handler.dart';
import 'package:post_app/src/data/datasource/remote/post_remote_data_source.dart';
import 'package:post_app/src/data/dtos/post_dto.dart';
import 'package:post_app/src/data/mapper/interface/mapper.dart';
import 'package:post_app/src/domain/entity/post.dart';
import 'package:post_app/src/domain/repository/i_post_repository.dart';

class PostRepository implements IPostRepository {
  final PostRemoteDataSource remoteDataSource;
  final Mapper<PostDTO, Post> mapper;

  PostRepository({
    required this.remoteDataSource,
    required this.mapper,
  });

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      final posts = await remoteDataSource.fetchPosts();
      return posts.map((dto) => mapper.toEntity(dto)).toList();
    } catch (e) {
      throw handleError(e as Exception);
    }
  }
}
