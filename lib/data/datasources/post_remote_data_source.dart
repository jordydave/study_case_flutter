import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:study_case/data/models/post_model.dart';
import 'package:study_case/data/models/post_response.dart';

import '../../utils/exception.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getListPost();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getListPost() async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      return PostResponse.fromJson(json.decode(response.body)).posts;
    } else {
      throw ServerException();
    }
  }
}
