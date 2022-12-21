import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_case/domain/entities/post.dart';
import 'package:study_case/domain/usecases/get_list_post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetListPost _getListPost;

  PostBloc(this._getListPost) : super(PostEmpty()) {
    on<PostGetList>(
      (event, emit) async {
        emit(PostLoading());
        final result = await _getListPost.execute();
        result.fold(
          (failure) {
            emit(PostError(failure.message));
          },
          (data) {
            emit(PostHasData(data));
          },
        );
      },
    );
  }
}
