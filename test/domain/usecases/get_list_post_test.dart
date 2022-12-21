import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:study_case/domain/entities/post.dart';
import 'package:study_case/domain/usecases/get_list_post.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetListPost usecase;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    usecase = GetListPost(mockPostRepository);
  });

  final tPosts = <Post>[];

  test('should get list of posts from the repository', () async {
    // arrange
    when(mockPostRepository.getListPost())
        .thenAnswer((_) async => Right(tPosts));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tPosts));
  });
}
