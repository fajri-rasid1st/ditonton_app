part of 'tv_show_list_bloc.dart';

abstract class TvShowlistState extends Equatable {
  const TvShowlistState();

  @override
  List<Object> get props => [];
}

class TvShowlistEmpty extends TvShowlistState {}

class TvShowlistLoading extends TvShowlistState {}

class TvShowlistError extends TvShowlistState {
  final String message;

  const TvShowlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowlistHasData extends TvShowlistState {
  final List<TvShow> onTheAirTvShows;
  final List<TvShow> popularTvShows;
  final List<TvShow> topRatedTvShows;

  const TvShowlistHasData(
    this.onTheAirTvShows,
    this.popularTvShows,
    this.topRatedTvShows,
  );

  @override
  List<Object> get props => [
        onTheAirTvShows,
        popularTvShows,
        topRatedTvShows,
      ];
}
