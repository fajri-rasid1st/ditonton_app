part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailEvent extends Equatable {
  const TvShowDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvShowDetail extends TvShowDetailEvent {
  final int id;

  const FetchTvShowDetail(this.id);

  @override
  List<Object> get props => [id];
}
