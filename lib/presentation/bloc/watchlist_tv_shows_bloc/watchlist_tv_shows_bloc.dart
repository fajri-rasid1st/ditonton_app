import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_watchlist_tv_shows.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_shows_event.dart';
part 'watchlist_tv_shows_state.dart';

class WatchlistTvShowsBloc
    extends Bloc<WatchlistTvShowsEvent, WatchlistTvShowsState> {
  final GetWatchlistTvShows getWatchlistTvShows;

  WatchlistTvShowsBloc({required this.getWatchlistTvShows})
      : super(WatchlistTvShowsEmpty()) {
    on<FetchWatchlistTvShows>((event, emit) async {
      emit(WatchlistTvShowsLoading());

      final result = await getWatchlistTvShows.execute();

      result.fold(
        (failure) => emit(WatchlistTvShowsError(failure.message)),
        (tvShows) => emit(WatchlistTvShowsHasData(tvShows)),
      );
    });
  }
}
