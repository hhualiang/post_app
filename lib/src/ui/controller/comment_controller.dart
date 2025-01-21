import 'package:flutter/material.dart';
import 'package:post_app/src/domain/entity/comment.dart';
import 'package:post_app/src/domain/usecase/usecase_interface/i_fetch_comments_usecase.dart';

class CommentController with ChangeNotifier {
  final FetchCommentsUseCase fetchCommentsUseCase;

  CommentController(this.fetchCommentsUseCase);

  List<Comment>? _comments;
  String? _errorMessage;
  bool _isLoading = false;

  List<Comment>? get comments => _comments;

  String? get errorMessage => _errorMessage;

  bool get isLoading => _isLoading;

  Future<void> getComments(int postId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedComments = await fetchCommentsUseCase.execute(postId);
      _comments = fetchedComments;
    } catch (error) {
      _errorMessage = error.toString();
      _comments = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
