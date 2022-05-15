part of 'tv_show_episodes_bloc.dart';

abstract class TvShowEpisodesState extends Equatable {
  const TvShowEpisodesState();

  @override
  List<Object> get props => [];
}

// Tv show episodes states
class TvShowEpisodesEmpty extends TvShowEpisodesState {}

class TvShowEpisodesLoading extends TvShowEpisodesState {}

class TvShowEpisodesError extends TvShowEpisodesState {
  final String message;

  const TvShowEpisodesError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowEpisodesHasData extends TvShowEpisodesState {
  final List<Episode> episodes;

  const TvShowEpisodesHasData(this.episodes);

  @override
  List<Object> get props => [episodes];
}
