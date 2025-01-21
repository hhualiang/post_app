import 'package:post_app/src/domain/entity/post.dart';

abstract class IPostRepository {
  Future<List<Post>> fetchPosts();
}
