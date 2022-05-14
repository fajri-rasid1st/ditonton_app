import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies}) : super(MovieSearchEmpty()) {
    on<OnMovieQueryChanged>((event, emit) async {
      emit(MovieSearchLoading());

      final query = event.query;
      final result = await searchMovies.execute(query);

      result.fold(
        (failure) => emit(MovieSearchError(failure.message)),
        (movies) => emit(MovieSearchHasData(movies)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}