import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:post_app/src/data/datasource/remote/post_remote_data_source.dart';
import 'package:post_app/src/data/mapper/impl/post_mapper.dart';
import 'package:post_app/src/data/repository/post_repository.dart';
import 'package:post_app/src/domain/usecase/usecase_impl/fetch_posts.dart';
import 'package:post_app/src/ui/controller/post_controller.dart';
import 'package:post_app/src/ui/view/home_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => buildHomeScreen(),
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
    final remoteDataSource = PostRemoteDataSourceImpl(dio);
    final mapper = PostMapper(); // Mapper<PostDTO, Post>
    final repository = PostRepositoryImpl(
      remoteDataSource: remoteDataSource,
      mapper: mapper,
    );
    final useCase = FetchPostsUseCaseImpl(repository);
    final controller = PostController(useCase);

    return HomeScreen(controller: controller);
  }
}
