import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_top_rated_movies.dart';
import 'package:flutter/material.dart';

class MovieListNotifier extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListNotifier({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  });

  List<Movie> _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingMoviesState = RequestState.empty;
  RequestState get nowPlayingMovieState => _nowPlayingMoviesState;

  List<Movie> _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.empty;
  RequestState get popularMoviesState => _popularMoviesState;

  List<Movie> _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedMoviesState = RequestState.empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingMoviesState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _nowPlayingMoviesState = RequestState.error;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingMovies = moviesData;
        _nowPlayingMoviesState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = RequestState.loading;
    notifyListeners();

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _popularMoviesState = RequestState.error;
        notifyListeners();
      },
      (moviesData) {
        _popularMovies = moviesData;
        _popularMoviesState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _topRatedMoviesState = RequestState.error;
        notifyListeners();
      },
      (moviesData) {
        _topRatedMovies = moviesData;
        _topRatedMoviesState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
