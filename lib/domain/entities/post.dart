import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  const Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });
  Post toEntity() => Post(
        userId: userId,
        id: id,
        title: title,
        body: body,
      );

  @override
  List<Object?> get props => [
        userId,
        id,
        title,
        body,
      ];
}
