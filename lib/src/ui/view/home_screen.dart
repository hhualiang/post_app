import 'package:flutter/material.dart';
import 'package:post_app/src/ui/controller/post_controller.dart';
import 'package:post_app/src/ui/widget/home_screen/post_grid.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final PostController controller;

  const HomeScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChangeNotifierProvider(
          create: (_) => controller..fetchPosts(),
          child: Consumer<PostController>(
            builder: (context, controller, _) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.errorMessage != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${controller.errorMessage!}',
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          controller.fetchPosts();  // Trigger a reload
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.posts == null || controller.posts!.isEmpty) {
                return const Center(
                  child: Text(
                    'No posts available.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              return PostGrid(
                posts: controller.posts!,
                onPostTap: (postId) {
                  Navigator.pushNamed(
                    context,
                    '/comments',
                    arguments: postId,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
