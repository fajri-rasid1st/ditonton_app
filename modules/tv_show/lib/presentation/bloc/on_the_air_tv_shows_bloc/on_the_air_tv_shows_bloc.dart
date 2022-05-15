import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/tvshow.dart';

part 'on_the_air_tv_shows_event.dart';
part 'on_the_air_tv_shows_state.dart';

class OnTheAirTvShowsBloc
    extends Bloc<OnTheAirTvShowsEvent, OnTheAirTvShowsState> {
  final GetOnTheAirTvShows getOnTheAirTvShows;

  OnTheAirTvShowsBloc({required this.getOnTheAirTvShows})
      : super(OnTheAirTvShowsEmpty()) {
    on<OnTheAirTvShowsEvent>((event, emit) async {
      emit(OnTheAirTvShowsLoading());

      final result = await getOnTheAirTvShows.execute();

      result.fold(
        (failure) => emit(OnTheAirTvShowsError(failure.message)),
        (tvShows) => emit(OnTheAirTvShowsHasData(tvShows)),
      );
    });
  }
}
