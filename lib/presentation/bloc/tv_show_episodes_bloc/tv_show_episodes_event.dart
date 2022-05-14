part of 'tv_show_episodes_bloc.dart';

abstract class TvShowEpisodesEvent extends Equatable {
  const TvShowEpisodesEvent();

  @override
  List<Object> get props => [];
}

class FetchTvShowEpisodes extends TvShowEpisodesEvent {
  final int id;
  final int seasonNumber;

  const FetchTvShowEpisodes(this.id, this.seasonNumber);

  @override
  List<Object> get props => [id];
}
