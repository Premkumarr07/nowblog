// lib/presentation/bloc/create_post/create_post_event.dart

import 'package:equatable/equatable.dart';

abstract class CreatePostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitPostEvent extends CreatePostEvent {
  final String title;
  final String body;
  final int userId;

  SubmitPostEvent({
    required this.title,
    required this.body,
    required this.userId,
  });

  @override
  List<Object?> get props => [title, body, userId];
}
