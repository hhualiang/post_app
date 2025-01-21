import 'package:post_app/src/domain/entity/post.dart';

abstract class IFetchPostsUseCase {
  Future<List<Post>> execute();
}
