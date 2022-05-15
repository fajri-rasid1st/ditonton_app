part of 'tv_show_watchlist_bloc.dart';

abstract class TvShowWatchlistEvent {
  const TvShowWatchlistEvent();
}

class LoadTvShowWatchlistStatus extends TvShowWatchlistEvent {
  final int id;

  const LoadTvShowWatchlistStatus(this.id);
}

class InsertTvShowWatchlist extends TvShowWatchlistEvent {
  final TvShowDetail tvShow;

  const InsertTvShowWatchlist(this.tvShow);
}

class RemoveTvShowWatchList extends TvShowWatchlistEvent {
  final TvShowDetail tvShow;

  const RemoveTvShowWatchList(this.tvShow);
}
