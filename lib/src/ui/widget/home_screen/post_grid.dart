import 'package:flutter/material.dart';

class PostGrid extends StatelessWidget {
  final List<dynamic> posts;
  final Function(int postId) onPostTap;

  const PostGrid({
    super.key,
    required this.posts,
    required this.onPostTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: posts.length,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        final post = posts[index];
        return GestureDetector(
          onTap: () => onPostTap(post.id),
          child: Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    post.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
