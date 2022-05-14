import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/search_tv_shows.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_show_search_event.dart';
part 'tv_show_search_state.dart';

class TvShowSearchBloc extends Bloc<TvShowSearchEvent, TvShowSearchState> {
  final SearchTvShows searchTvShows;

  TvShowSearchBloc({required this.searchTvShows}) : super(TvShowSearchEmpty()) {
    on<OnTvShowQueryChanged>((event, emit) async {
      emit(TvShowSearchLoading());

      final query = event.query;
      final result = await searchTvShows.execute(query);

      result.fold(
        (failure) => emit(TvShowSearchError(failure.message)),
        (tvShows) => emit(TvShowSearchHasData(tvShows)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  // Function to create debouncer of search
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
