part of 'tv_show_episodes_bloc.dart';

abstract class TvShowEpisodesEvent {
  const TvShowEpisodesEvent();
}

class FetchTvShowEpisodes extends TvShowEpisodesEvent {
  final int id;
  final int seasonNumber;

  const FetchTvShowEpisodes(this.id, this.seasonNumber);
}
