// lib/presentation/bloc/create_post/create_post_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_post_event.dart';
import 'create_post_state.dart';
import '../../../domain/repositories/user_repository.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final UserRepository userRepository;

  CreatePostBloc({required this.userRepository}) : super(CreatePostInitial()) {
    on<SubmitPostEvent>((event, emit) async {
      emit(CreatePostLoading());
      try {
        // Pass positional arguments as expected by the repository method
        final result = await userRepository.createPost(
          event.title,
          event.body,
          event.userId,
        );

        // Handle result using fold (Either)
        result.fold(
              (failure) => emit(CreatePostFailure(message: failure.toString())),
              (_) => emit(CreatePostSuccess()),
        );
      } catch (e) {
        emit(CreatePostFailure(message: e.toString()));
      }
    });
  }
}
