import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_show/tvshow.dart';

part 'tv_show_list_event.dart';
part 'tv_show_list_state.dart';

class TvShowlistBloc extends Bloc<TvShowlistEvent, TvShowlistState> {
  final GetOnTheAirTvShows getOnTheAirTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  TvShowlistBloc({
    required this.getOnTheAirTvShows,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  }) : super(TvShowlistEmpty()) {
    on<FetchTvShowlist>((event, emit) async {
      emit(TvShowlistLoading());

      final onTheAirResult = await getOnTheAirTvShows.execute();
      final popularResult = await getPopularTvShows.execute();
      final topRatedResult = await getTopRatedTvShows.execute();

      onTheAirResult.fold(
        (failure) => emit(TvShowlistError(failure.message)),
        (onTheAirTvShows) {
          popularResult.fold(
            (failure) => emit(TvShowlistError(failure.message)),
            (popularTvShows) {
              topRatedResult.fold(
                (failure) => emit(TvShowlistError(failure.message)),
                (topRatedTvShows) {
                  emit(TvShowlistHasData(
                    onTheAirTvShows,
                    popularTvShows,
                    topRatedTvShows,
                  ));
                },
              );
            },
          );
        },
      );
    });
  }
}
