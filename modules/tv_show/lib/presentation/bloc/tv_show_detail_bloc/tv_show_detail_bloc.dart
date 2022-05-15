import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tvshow.dart';

part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;

  TvShowDetailBloc({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
  }) : super(TvShowDetailEmpty()) {
    on<FetchTvShowDetail>((event, emit) async {
      emit(TvShowDetailLoading());

      final id = event.id;
      final detailResult = await getTvShowDetail.execute(id);
      final recommendationResult = await getTvShowRecommendations.execute(id);

      detailResult.fold(
        (failure) {
          emit(TvShowDetailError(failure.message));
        },
        (tvShowDetail) {
          recommendationResult.fold(
            (failure) {
              emit(TvShowDetailError(failure.message));
            },
            (recommendations) {
              emit(TvShowDetailHasData(tvShowDetail, recommendations));
            },
          );
        },
      );
    });
  }
}
