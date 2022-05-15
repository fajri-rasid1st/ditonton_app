part of 'tv_show_search_bloc.dart';

abstract class TvShowSearchState extends Equatable {
  const TvShowSearchState();

  @override
  List<Object> get props => [];
}

class TvShowSearchEmpty extends TvShowSearchState {}

class TvShowSearchLoading extends TvShowSearchState {}

class TvShowSearchError extends TvShowSearchState {
  final String message;

  const TvShowSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowSearchHasData extends TvShowSearchState {
  final List<TvShow> tvShows;

  const TvShowSearchHasData(this.tvShows);

  @override
  List<Object> get props => [tvShows];
}
