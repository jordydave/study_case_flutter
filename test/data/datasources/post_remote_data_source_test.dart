import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:study_case/data/datasources/post_remote_data_source.dart';
import 'package:study_case/data/models/post_response.dart';
import 'package:http/http.dart' as http;
import 'package:study_case/utils/exception.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  late PostRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = PostRemoteDataSourceImpl(client: mockHttpClient);
  });

  group(
    'get list of post',
    () {
      final tPostList = PostResponse.fromJson(
        json.decode(
          readJson('dummy_data/post.json'),
        ),
      ).posts;

      test(
        'should return list of Post Model when the response code is 200',
        () async {
          // arrange
          when(mockHttpClient.get(Uri.parse(baseUrl))).thenAnswer((_) async =>
              http.Response(readJson('dummy_data/post.json'), 200));
          // act
          final result = await dataSource.getListPost();
          // assert
          expect(result, equals(tPostList));
        },
      );
      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          when(mockHttpClient.get(Uri.parse(baseUrl)))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getListPost();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
