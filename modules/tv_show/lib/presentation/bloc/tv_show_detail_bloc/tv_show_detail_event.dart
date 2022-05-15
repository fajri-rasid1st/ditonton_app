part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailEvent {
  const TvShowDetailEvent();
}

class FetchTvShowDetail extends TvShowDetailEvent {
  final int id;

  const FetchTvShowDetail(this.id);
}
