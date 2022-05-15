import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tvshow.dart';

part 'top_rated_tv_shows_event.dart';
part 'top_rated_tv_shows_state.dart';

class TopRatedTvShowsBloc
    extends Bloc<TopRatedTvShowsEvent, TopRatedTvShowsState> {
  final GetTopRatedTvShows getTopRatedTvShows;

  TopRatedTvShowsBloc({required this.getTopRatedTvShows})
      : super(TopRatedTvShowsEmpty()) {
    on<TopRatedTvShowsEvent>((event, emit) async {
      emit(TopRatedTvShowsLoading());

      final result = await getTopRatedTvShows.execute();

      result.fold(
        (failure) => emit(TopRatedTvShowsError(failure.message)),
        (movies) => emit(TopRatedTvShowsHasData(movies)),
      );
    });
  }
}
