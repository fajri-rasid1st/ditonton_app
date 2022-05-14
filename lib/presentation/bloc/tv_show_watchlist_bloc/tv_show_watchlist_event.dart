part of 'tv_show_watchlist_bloc.dart';

abstract class TvShowWatchlistEvent extends Equatable {
  const TvShowWatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadTvShowWatchlistStatus extends TvShowWatchlistEvent {
  final int id;

  const LoadTvShowWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class InsertTvShowWatchlist extends TvShowWatchlistEvent {
  final TvShowDetail tvShow;

  const InsertTvShowWatchlist(this.tvShow);

  @override
  List<Object> get props => [tvShow];
}

class RemoveTvShowWatchList extends TvShowWatchlistEvent {
  final TvShowDetail tvShow;

  const RemoveTvShowWatchList(this.tvShow);

  @override
  List<Object> get props => [tvShow];
}
