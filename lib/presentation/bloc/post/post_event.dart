// lib/presentation/bloc/post/post_event.dart
part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchUserPostsEvent extends PostEvent {
  final int userId;

  const FetchUserPostsEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
