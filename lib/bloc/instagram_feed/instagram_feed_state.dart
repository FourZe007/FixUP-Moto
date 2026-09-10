import 'package:equatable/equatable.dart';
import 'package:fixupmoto/global/model.dart';

enum InstagramFeedStatus { initial, loading, loaded, error }

class InstagramFeedState extends Equatable {
  final InstagramFeedStatus status;
  final List<ModelInstagramPost> posts;
  final String errorMessage;

  const InstagramFeedState({
    this.status = InstagramFeedStatus.initial,
    this.posts = const [],
    this.errorMessage = '',
  });

  InstagramFeedState copyWith({
    InstagramFeedStatus? status,
    List<ModelInstagramPost>? posts,
    String? errorMessage,
  }) {
    return InstagramFeedState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, posts, errorMessage];
}
