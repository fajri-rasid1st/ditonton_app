part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieWatchlistStatus extends MovieWatchlistEvent {
  final int id;

  const LoadMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class InsertMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;

  const InsertMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveMovieWatchList extends MovieWatchlistEvent {
  final MovieDetail movie;

  const RemoveMovieWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}
