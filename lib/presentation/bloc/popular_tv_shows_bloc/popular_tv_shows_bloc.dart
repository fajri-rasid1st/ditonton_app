import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_popular_tv_shows.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tv_shows_event.dart';
part 'popular_tv_shows_state.dart';

class PopularTvShowsBloc
    extends Bloc<PopularTvShowsEvent, PopularTvShowsState> {
  final GetPopularTvShows getPopularTvShows;

  PopularTvShowsBloc({required this.getPopularTvShows})
      : super(PopularTvShowsEmpty()) {
    on<PopularTvShowsEvent>((event, emit) async {
      emit(PopularTvShowsLoading());

      final result = await getPopularTvShows.execute();

      result.fold(
        (failure) => emit(PopularTvShowsError(failure.message)),
        (tvShows) => emit(PopularTvShowsHasData(tvShows)),
      );
    });
  }
}
