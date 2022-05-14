part of 'watchlist_tv_shows_bloc.dart';

abstract class WatchlistTvShowsState extends Equatable {
  const WatchlistTvShowsState();

  @override
  List<Object> get props => [];
}

class WatchlistTvShowsEmpty extends WatchlistTvShowsState {}

class WatchlistTvShowsLoading extends WatchlistTvShowsState {}

class WatchlistTvShowsError extends WatchlistTvShowsState {
  final String message;

  const WatchlistTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvShowsHasData extends WatchlistTvShowsState {
  final List<TvShow> tvShows;

  const WatchlistTvShowsHasData(this.tvShows);

  @override
  List<Object> get props => [tvShows];
}
