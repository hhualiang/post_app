import 'package:flutter/material.dart';
import 'package:post_app/src/domain/entity/post.dart';
import 'package:post_app/src/ui/controller/comment_controller.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatelessWidget {
  final Post post;

  const CommentScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CommentController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for Post ${post.id}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : controller.errorMessage != null
                ? Center(child: Text('Error: ${controller.errorMessage}'))
                : ListView(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(bottom: 24.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                post.body,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (controller.comments != null &&
                          controller.comments!.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            'Comments',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      if (controller.comments != null &&
                          controller.comments!.isNotEmpty)
                        ...controller.comments!.map(
                          (comment) {
                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.only(bottom: 12.0),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16.0),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        comment.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      comment.email,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  comment.body,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          },
                        ),
                      if (controller.comments == null ||
                          controller.comments!.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: Text(
                              'No comments available.',
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
      ),
    );
  }
}
