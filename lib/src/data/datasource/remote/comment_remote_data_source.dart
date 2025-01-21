import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:post_app/src/data/dtos/comment_dto.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentDTO>> fetchComments(int postId);
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  static const _platform = MethodChannel('com.example.post_app/channel');

  @override
  Future<List<CommentDTO>> fetchComments(int postId) async {
    try {
      final result = await _platform.invokeMethod<String>(
        'fetchComments',
        {
          'postId': postId,
        },
      );
      if (result == null) {
        throw Exception('No response from the platform.');
      }
      final List<dynamic> jsonList = json.decode(result);
      return jsonList.map((json) => CommentDTO.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch comments: $e');
    }
  }
}
