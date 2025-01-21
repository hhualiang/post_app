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
      ),
      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : controller.errorMessage != null
              ? Center(child: Text('Error: ${controller.errorMessage}'))
              : ListView.builder(
                  itemCount: controller.comments?.length ?? 0,
                  itemBuilder: (context, index) {
                    final comment = controller.comments![index];
                    return ListTile(
                      title: Text(comment.name),
                      subtitle: Text(comment.body),
                      trailing: Text(comment.email),
                    );
                  },
                ),
    );
  }
}
