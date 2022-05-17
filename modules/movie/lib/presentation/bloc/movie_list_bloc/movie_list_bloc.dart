import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovielistBloc extends Bloc<MovielistEvent, MovielistState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovielistBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovielistEmpty()) {
    on<FetchMovielist>((event, emit) async {
      emit(MovielistLoading());

      final nowPlayingResult = await getNowPlayingMovies.execute();
      final popularResult = await getPopularMovies.execute();
      final topRatedResult = await getTopRatedMovies.execute();

      nowPlayingResult.fold(
        (failure) => emit(MovielistError(failure.message)),
        (nowPlayingMovies) {
          popularResult.fold(
            (failure) => emit(MovielistError(failure.message)),
            (popularMovies) {
              topRatedResult.fold(
                (failure) => emit(MovielistError(failure.message)),
                (topRatedMovies) {
                  emit(MovielistHasData(
                    nowPlayingMovies,
                    popularMovies,
                    topRatedMovies,
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
