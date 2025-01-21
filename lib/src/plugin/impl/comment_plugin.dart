import 'package:flutter/services.dart';
import 'package:post_app/src/plugin/interface/i_comment_plugin.dart';

class CommentPlugin implements ICommentPlugin {
  static const platform = MethodChannel('com.example.post_app/channel');

  @override
  Future<String> getComments(String channel) async {
    try {
      final String? result = await platform.invokeMethod(channel);
      return result ?? 'No result from native code';
    } on PlatformException catch (e) {
      throw Exception("Failed to invoke native method: '${e.message}'.");
    }
  }
}
