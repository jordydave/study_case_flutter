import 'package:dartz/dartz.dart';
import 'package:study_case/domain/entities/post.dart';

import '../../utils/failure.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getListPost();
}
