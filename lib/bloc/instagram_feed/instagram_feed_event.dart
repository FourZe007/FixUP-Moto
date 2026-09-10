import 'package:equatable/equatable.dart';

abstract class InstagramFeedEvent extends Equatable {
  const InstagramFeedEvent();

  @override
  List<Object?> get props => [];
}

class InstagramFeedRequested extends InstagramFeedEvent {
  const InstagramFeedRequested();
}
