import 'package:flutter/material.dart';
import 'package:post_app/src/domain/entity/post.dart';
import 'package:post_app/src/domain/usecase/usecase_interface/i_fetch_posts_usecase.dart';

class PostController with ChangeNotifier {
  final IFetchPostsUseCase fetchPostsUseCase;

  PostController(this.fetchPostsUseCase);

  // States
  List<Post>? _posts;
  String? _errorMessage;
  bool _isLoading = false;

  List<Post>? get posts => _posts;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  // Fetch posts and manage states
  Future<void> fetchPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final posts = await fetchPostsUseCase.execute();
      if (posts.isEmpty) {
        _errorMessage = 'No posts found';
      } else {
        _posts = posts;
      }
    } catch (error) {
      _errorMessage = 'Error occurred while fetching posts';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
