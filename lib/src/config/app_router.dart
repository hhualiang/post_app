import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:post_app/src/data/datasource/remote/comment_remote_data_source.dart';
import 'package:post_app/src/data/datasource/remote/post_remote_data_source.dart';
import 'package:post_app/src/data/mapper/impl/comment_mapper.dart';
import 'package:post_app/src/data/mapper/impl/post_mapper.dart';
import 'package:post_app/src/data/repository/comment_repository.dart';
import 'package:post_app/src/data/repository/post_repository.dart';
import 'package:post_app/src/domain/usecase/usecase_impl/fetch_posts_usecase.dart';
import 'package:post_app/src/domain/usecase/usecase_interface/i_fetch_comments_usecase.dart';
import 'package:post_app/src/ui/controller/comment_controller.dart';
import 'package:post_app/src/ui/controller/post_controller.dart';
import 'package:post_app/src/ui/view/comment_screen.dart';
import 'package:post_app/src/ui/view/home_screen.dart';
import 'package:provider/provider.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => buildHomeScreen(),
        );
      case '/comments':
        final postId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => buildCommentScreen(postId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('404 Not Found'),
            ),
          ),
        );
    }
  }

  Widget buildHomeScreen() {
    final dio = Dio();
    final postRemoteDataSource = PostRemoteDataSourceImpl(dio);
    final postMapper = PostMapper();
    final postRepository = PostRepository(
      remoteDataSource: postRemoteDataSource,
      mapper: postMapper,
    );
    final fetchPostsUseCase = FetchPostsUseCaseImpl(postRepository);
    final postController = PostController(fetchPostsUseCase);
    return HomeScreen(controller: postController);
  }

  Widget buildCommentScreen(int postId) {
    final commentRemoteDataSource = CommentRemoteDataSourceImpl();
    final commentMapper = CommentMapper();
    final commentRepository = CommentRepository(
      remoteDataSource: commentRemoteDataSource,
      mapper: commentMapper,
    );
    final fetchCommentsUseCase = FetchCommentsUseCaseImpl(commentRepository);
    final commentController = CommentController(fetchCommentsUseCase);
    commentController.getComments(postId);
    return ChangeNotifierProvider(
      create: (_) => commentController,
      child: CommentScreen(postId: postId),
    );
  }
}
