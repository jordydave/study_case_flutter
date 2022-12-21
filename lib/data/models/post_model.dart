import 'package:equatable/equatable.dart';

import '../../domain/entities/post.dart';

class PostModel extends Equatable {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  const PostModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json['userId'] as int?,
        id: json['id'] as int?,
        title: json['title'] as String?,
        body: json['body'] as String?,
      );

  Post toEntity() => Post(
        userId: userId,
        id: id,
        title: title,
        body: body,
      );

  @override
  List<Object?> get props => [userId, id, title, body];
}
