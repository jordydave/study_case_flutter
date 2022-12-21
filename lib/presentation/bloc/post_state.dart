part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostEmpty extends PostState {}

class PostLoading extends PostState {}

// ignore: must_be_immutable
class PostHasData extends PostState {
  List<Post>? posts;

  PostHasData(this.posts);

  @override
  List<Object> get props => [posts!];
}

class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [message];
}
