// lib/presentation/bloc/create_post/create_post_state.dart

import 'package:equatable/equatable.dart';

abstract class CreatePostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostSuccess extends CreatePostState {}

class CreatePostFailure extends CreatePostState {
  final String message;

  CreatePostFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
