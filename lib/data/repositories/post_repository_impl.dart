import 'package:dartz/dartz.dart';
import 'package:study_case/data/datasources/post_remote_data_source.dart';
import 'package:study_case/domain/entities/post.dart';
import 'package:study_case/domain/repositories/post_repository.dart';
import 'package:study_case/utils/failure.dart';

import '../../utils/exception.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Post>>> getListPost() async {
    try {
      final result = await remoteDataSource.getListPost();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }
}
