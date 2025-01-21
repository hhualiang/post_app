import 'package:dio/dio.dart';

import 'package:post_app/src/data/core/error_handler.dart';
import 'package:post_app/src/data/dtos/post_dto.dart';

abstract class PostRemoteDataSource {
  Future<List<PostDTO>> fetchPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PostDTO>> fetchPosts() async {
    const String url = 'https://jsonplaceholder.typicode.com/posts';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => PostDTO.fromJson(json))
          .toList();
    } else {
      throw AppException('Failed to fetch posts from server');
    }
  }
}
