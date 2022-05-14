part of 'tv_show_watchlist_bloc.dart';

abstract class TvShowWatchlistState extends Equatable {
  const TvShowWatchlistState();

  @override
  List<Object> get props => [];
}

class TvShowWatchlistStatusEmpty extends TvShowWatchlistState {}

class TvShowWatchlistStatusError extends TvShowWatchlistState {
  final String message;

  const TvShowWatchlistStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowWatchlistStatusHasData extends TvShowWatchlistState {
  final bool isWatchlist;

  const TvShowWatchlistStatusHasData(this.isWatchlist);

  @override
  List<Object> get props => [isWatchlist];
}

class InsertOrRemoveTvShowWatchlistSuccess extends TvShowWatchlistState {
  final String successMessage;

  const InsertOrRemoveTvShowWatchlistSuccess(this.successMessage);

  @override
  List<Object> get props => [successMessage];
}

class InsertOrRemoveTvShowWatchlistFailed extends TvShowWatchlistState {
  final String failureMessage;

  const InsertOrRemoveTvShowWatchlistFailed(this.failureMessage);

  @override
  List<Object> get props => [failureMessage];
}
