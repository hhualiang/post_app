import 'package:flutter/material.dart';
import 'package:post_app/src/domain/entity/post.dart';
import 'package:post_app/src/ui/controller/post_controller.dart';
import 'package:post_app/src/ui/widget/home_screen/post_grid.dart';

class HomeScreen extends StatelessWidget {
  final PostController controller;

  const HomeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts App'),
      ),
      body: FutureBuilder<List<Post>>(
        future: controller.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else if (snapshot.hasData) {
            return PostGrid(posts: snapshot.data!);
          } else {
            return const Center(
              child: Text('No posts found'),
            );
          }
        },
      ),
    );
  }
}
