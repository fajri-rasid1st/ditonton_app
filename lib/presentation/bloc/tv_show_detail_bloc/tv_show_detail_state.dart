part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailState extends Equatable {
  const TvShowDetailState();

  @override
  List<Object> get props => [];
}

class TvShowDetailEmpty extends TvShowDetailState {}

class TvShowDetailLoading extends TvShowDetailState {}

class TvShowDetailError extends TvShowDetailState {
  final String message;

  const TvShowDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowDetailHasData extends TvShowDetailState {
  final TvShowDetail tvShowDetail;
  final List<TvShow> recommendations;

  const TvShowDetailHasData(this.tvShowDetail, this.recommendations);

  @override
  List<Object> get props => [tvShowDetail, recommendations];
}
