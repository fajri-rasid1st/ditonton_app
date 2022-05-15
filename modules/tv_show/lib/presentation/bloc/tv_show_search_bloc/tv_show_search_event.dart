part of 'tv_show_search_bloc.dart';

abstract class TvShowSearchEvent {
  const TvShowSearchEvent();
}

class OnTvShowQueryChanged extends TvShowSearchEvent {
  final String query;

  const OnTvShowQueryChanged(this.query);
}
