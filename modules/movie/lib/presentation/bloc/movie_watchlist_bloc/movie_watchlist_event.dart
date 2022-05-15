part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent {
  const MovieWatchlistEvent();
}

class LoadMovieWatchlistStatus extends MovieWatchlistEvent {
  final int id;

  const LoadMovieWatchlistStatus(this.id);
}

class InsertMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;

  const InsertMovieWatchlist(this.movie);
}

class RemoveMovieWatchList extends MovieWatchlistEvent {
  final MovieDetail movie;

  const RemoveMovieWatchList(this.movie);
}
