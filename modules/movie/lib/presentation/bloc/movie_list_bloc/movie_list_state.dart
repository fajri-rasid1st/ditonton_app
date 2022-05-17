part of 'movie_list_bloc.dart';

abstract class MovielistState extends Equatable {
  const MovielistState();

  @override
  List<Object> get props => [];
}

class MovielistEmpty extends MovielistState {}

class MovielistLoading extends MovielistState {}

class MovielistError extends MovielistState {
  final String message;

  const MovielistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovielistHasData extends MovielistState {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;

  const MovielistHasData(
    this.nowPlayingMovies,
    this.popularMovies,
    this.topRatedMovies,
  );

  @override
  List<Object> get props => [
        nowPlayingMovies,
        popularMovies,
        topRatedMovies,
      ];
}
