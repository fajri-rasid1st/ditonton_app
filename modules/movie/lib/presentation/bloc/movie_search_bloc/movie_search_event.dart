part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent {
  const MovieSearchEvent();
}

class OnMovieQueryChanged extends MovieSearchEvent {
  final String query;

  const OnMovieQueryChanged(this.query);
}
