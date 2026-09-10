import 'package:fixupmoto/bloc/instagram_feed/instagram_feed_event.dart';
import 'package:fixupmoto/bloc/instagram_feed/instagram_feed_state.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstagramFeedBloc extends Bloc<InstagramFeedEvent, InstagramFeedState> {
  InstagramFeedBloc() : super(const InstagramFeedState()) {
    on<InstagramFeedRequested>(_onRequested);
  }

  Future<void> _onRequested(
    InstagramFeedRequested event,
    Emitter<InstagramFeedState> emit,
  ) async {
    emit(state.copyWith(status: InstagramFeedStatus.loading));

    try {
      final posts = await GlobalAPI.fetchInstagramFeed();

      emit(state.copyWith(
        status: InstagramFeedStatus.loaded,
        posts: posts,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: InstagramFeedStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
