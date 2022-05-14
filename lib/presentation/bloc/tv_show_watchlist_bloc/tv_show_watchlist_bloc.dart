import 'package:ditonton/domain/entities/tv_show_entities/tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/add_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/delete_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_watchlist_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_show_watchlist_event.dart';
part 'tv_show_watchlist_state.dart';

class TvShowWatchlistBloc
    extends Bloc<TvShowWatchlistEvent, TvShowWatchlistState> {
  final GetTvShowWatchListStatus getTvShowWatchListStatus;
  final AddTvShowWatchlist addTvShowWatchlist;
  final DeleteTvShowWatchlist deleteTvShowWatchlist;

  TvShowWatchlistBloc({
    required this.getTvShowWatchListStatus,
    required this.addTvShowWatchlist,
    required this.deleteTvShowWatchlist,
  }) : super(TvShowWatchlistStatusEmpty()) {
    on<LoadTvShowWatchlistStatus>((event, emit) async {
      final id = event.id;
      final result = await getTvShowWatchListStatus.execute(id);

      result.fold(
        (failure) => emit(TvShowWatchlistStatusError(failure.message)),
        (isWatchlist) => emit(TvShowWatchlistStatusHasData(isWatchlist)),
      );
    });

    on<InsertTvShowWatchlist>((event, emit) async {
      final tvShow = event.tvShow;
      final result = await addTvShowWatchlist.execute(tvShow);

      result.fold(
        (failure) => emit(InsertOrRemoveTvShowWatchlistFailed(failure.message)),
        (message) => emit(InsertOrRemoveTvShowWatchlistSuccess(message)),
      );

      add(LoadTvShowWatchlistStatus(tvShow.id));
    });

    on<RemoveTvShowWatchList>((event, emit) async {
      final tvShow = event.tvShow;
      final result = await deleteTvShowWatchlist.execute(tvShow);

      result.fold(
        (failure) => emit(InsertOrRemoveTvShowWatchlistFailed(failure.message)),
        (message) => emit(InsertOrRemoveTvShowWatchlistSuccess(message)),
      );

      add(LoadTvShowWatchlistStatus(tvShow.id));
    });
  }
}
