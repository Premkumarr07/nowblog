// lib/presentation/bloc/post/post_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_user_posts.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetUserPosts getUserPosts;

  PostBloc({required this.getUserPosts}) : super(PostInitial()) {
    on<FetchUserPostsEvent>((event, emit) async {
      emit(PostLoading());
      final result = await getUserPosts.execute(event.userId);
      result.fold(
            (failure) => emit(PostError(failure.message)),
            (posts) => emit(PostLoaded(posts)),
      );
    });
  }
}
