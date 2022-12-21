import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:study_case/data/models/post_model.dart';
import 'package:study_case/data/repositories/post_repository_impl.dart';
import 'package:study_case/domain/entities/post.dart';
import 'package:study_case/utils/exception.dart';
import 'package:study_case/utils/failure.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late PostRepositoryImpl repository;
  late MockPostRemoteDataSource mockPostRemoteDataSource;

  setUp(() {
    mockPostRemoteDataSource = MockPostRemoteDataSource();
    repository = PostRepositoryImpl(remoteDataSource: mockPostRemoteDataSource);
  });

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

  final tPostModelList = <PostModel>[tPostModel];
  final tPostList = <Post>[tPost];

  group(
    'List of Post',
    () {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockPostRemoteDataSource.getListPost())
            .thenAnswer((_) async => tPostModelList);
        // act
        final result = await repository.getListPost();
        // assert
        verify(mockPostRemoteDataSource.getListPost());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tPostList);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockPostRemoteDataSource.getListPost())
            .thenThrow(ServerException());
        // act
        final result = await repository.getListPost();
        // assert
        verify(mockPostRemoteDataSource.getListPost());
        expect(result, equals(const Left(ServerFailure(''))));
      });
    },
  );
}
