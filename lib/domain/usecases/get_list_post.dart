import 'package:dartz/dartz.dart';
import 'package:study_case/domain/entities/post.dart';
import 'package:study_case/domain/repositories/post_repository.dart';
import 'package:study_case/utils/failure.dart';

class GetListPost {
  final PostRepository repository;

  GetListPost(this.repository);

  Future<Either<Failure, List<Post>>> execute() {
    return repository.getListPost();
  }
}
