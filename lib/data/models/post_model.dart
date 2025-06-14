import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/post.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Post {
  PostModel({
    required int id,
    required String title,
    required String body,
    required int userId,
  }) : super(
    id: id,
    title: title,
    body: body,
    userId: userId,
  );

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
