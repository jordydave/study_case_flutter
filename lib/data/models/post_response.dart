import 'package:equatable/equatable.dart';
import 'package:study_case/data/models/post_model.dart';

class PostResponse extends Equatable {
  final List<PostModel> posts;

  const PostResponse({required this.posts});

  factory PostResponse.fromJson(List<dynamic> json) => PostResponse(
        posts: List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [posts];
}
