import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:study_case/data/datasources/post_remote_data_source.dart';
import 'package:study_case/domain/repositories/post_repository.dart';

@GenerateMocks(
  [
    PostRepository,
    PostRemoteDataSource,
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient)
  ]
)
void main() {}
