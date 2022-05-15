part of 'on_the_air_tv_shows_bloc.dart';

abstract class OnTheAirTvShowsState extends Equatable {
  const OnTheAirTvShowsState();

  @override
  List<Object> get props => [];
}

class OnTheAirTvShowsEmpty extends OnTheAirTvShowsState {}

class OnTheAirTvShowsLoading extends OnTheAirTvShowsState {}

class OnTheAirTvShowsError extends OnTheAirTvShowsState {
  final String message;

  const OnTheAirTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class OnTheAirTvShowsHasData extends OnTheAirTvShowsState {
  final List<TvShow> tvShows;

  const OnTheAirTvShowsHasData(this.tvShows);

  @override
  List<Object> get props => [tvShows];
}
