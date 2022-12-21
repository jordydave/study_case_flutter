import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_case/domain/entities/post.dart';
import 'package:study_case/domain/usecases/get_list_post.dart';
import 'package:study_case/presentation/bloc/post_bloc.dart';
import 'package:study_case/utils/failure.dart';

import 'post_test.mocks.dart';

@GenerateMocks([GetListPost])
void main() {
  late PostBloc postBloc;
  late MockGetListPost mockGetListPost;

  setUp(() {
    mockGetListPost = MockGetListPost();
    postBloc = PostBloc(mockGetListPost);
  });

  const tPostModel = Post(
    userId: 1,
    id: 1,
    title: 'title',
    body: 'body',
  );
  final tPostModelList = <Post>[tPostModel];

  test('initial state should be empty', () {
    expect(postBloc.state, equals(PostEmpty()));
  });
  blocTest<PostBloc, PostState>(
    'Should emit [Loading, HasData] when List Post is gotten successfully',
    build: () {
      when(mockGetListPost.execute())
          .thenAnswer((_) async => Right(tPostModelList));
      return postBloc;
    },
    act: (bloc) => bloc.add(PostGetList()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PostLoading(),
      PostHasData(tPostModelList),
    ],
    verify: (bloc) {
      verify(mockGetListPost.execute());
    },
  );

  blocTest<PostBloc, PostState>(
    'Should emit [Loading, Error] when List Post is unsuccessfull.',
    build: () {
      when(mockGetListPost.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return postBloc;
    },
    act: (bloc) => bloc.add(PostGetList()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PostLoading(),
      const PostError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetListPost.execute());
    },
  );
}
