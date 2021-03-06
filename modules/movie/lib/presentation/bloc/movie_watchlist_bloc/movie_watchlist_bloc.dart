import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetMovieWatchListStatus getMovieWatchListStatus;
  final AddMovieWatchlist addMovieWatchlist;
  final DeleteMovieWatchlist deleteMovieWatchlist;

  MovieWatchlistBloc({
    required this.getMovieWatchListStatus,
    required this.addMovieWatchlist,
    required this.deleteMovieWatchlist,
  }) : super(MovieWatchlistStatusEmpty()) {
    on<LoadMovieWatchlistStatus>((event, emit) async {
      final id = event.id;
      final result = await getMovieWatchListStatus.execute(id);

      result.fold(
        (failure) => emit(MovieWatchlistStatusError(failure.message)),
        (isWatchlist) => emit(MovieWatchlistStatusHasData(isWatchlist)),
      );
    });

    on<InsertMovieWatchlist>((event, emit) async {
      final movie = event.movie;
      final result = await addMovieWatchlist.execute(movie);

      result.fold(
        (failure) => emit(InsertOrRemoveMovieWatchlistFailed(failure.message)),
        (message) => emit(InsertOrRemoveMovieWatchlistSuccess(message)),
      );

      add(LoadMovieWatchlistStatus(movie.id));
    });

    on<RemoveMovieWatchList>((event, emit) async {
      final movie = event.movie;
      final result = await deleteMovieWatchlist.execute(movie);

      result.fold(
        (failure) => emit(InsertOrRemoveMovieWatchlistFailed(failure.message)),
        (message) => emit(InsertOrRemoveMovieWatchlistSuccess(message)),
      );

      add(LoadMovieWatchlistStatus(movie.id));
    });
  }
}
