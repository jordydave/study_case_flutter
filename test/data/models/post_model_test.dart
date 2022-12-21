import 'package:flutter_test/flutter_test.dart';
import 'package:study_case/data/models/post_model.dart';
import 'package:study_case/domain/entities/post.dart';

void main() {
  const tPostModel = PostModel(
    userId: 1,
    id: 1,
    title: 'title',
    body: 'body',
  );

  const tPost = Post(
    userId: 1,
    id: 1,
    title: 'title',
    body: 'body',
  );
  test('should be a subclass of Post entity', () async {
    final result = tPostModel.toEntity();
    expect(result, tPost);
  });
}
