import 'package:flutter/material.dart';
import 'package:post_app/src/ui/widget/home_screen/post_grid.dart';
import 'package:provider/provider.dart';
import '../controller/post_controller.dart';

class HomeScreen extends StatelessWidget {
  final PostController controller;

  const HomeScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => controller..fetchPosts(),
        child: Consumer<PostController>(builder: (context, controller, _) {
          return controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.errorMessage != null
              ? Center(child: Text(controller.errorMessage!))
              : controller.posts != null && controller.posts!.isNotEmpty
              ? PostGrid(
            posts: controller.posts!,
            onPostTap: (postId) {
              Navigator.pushNamed(
                context,
                '/comments',
                arguments: postId,
              );
            },
          )
              : const Center(child: Text('No posts available.'));
        },),
      ),
    );
  }
}
