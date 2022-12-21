import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:study_case/data/models/post_model.dart';
import 'package:study_case/data/models/post_response.dart';

import '../../json_reader.dart';

void main() {
  const tPostModel = PostModel(
    userId: 1,
    id: 1,
    title: 'title',
    body: 'body',
  );
  const tPostResponseModel = PostResponse(
    posts: <PostModel>[tPostModel],
  );

  test('should return a valid model from JSON', () async {
    // arrange
    final List<dynamic> jsonMap = json.decode(readJson('dummy_data/post.json'));
    // act
    final result = PostResponse.fromJson(jsonMap);
    // assert
    expect(result, tPostResponseModel);
  });
}
