import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/comment_controller.dart';

class CommentScreen extends StatelessWidget {
  final int postId;

  const CommentScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CommentController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for Post $postId'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : controller.errorMessage != null
            ? Center(
          child: Text(
            'Error: ${controller.errorMessage}',
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        )
            : ListView.builder(
          itemCount: controller.comments?.length ?? 0,
          itemBuilder: (context, index) {
            final comment = controller.comments![index];
            return Card(
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            comment.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          flex: 2,
                          child: Text(
                            comment.email,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      comment.body,
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3, // Limit body text to 3 lines
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
