import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecases/add_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/delete_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_watchlist_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MovieDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added Movie to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed Movie from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetMovieWatchListStatus getMovieWatchListStatus;
  final AddMovieWatchlist addMovieWatchlist;
  final DeleteMovieWatchlist deleteMovieWatchlist;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getMovieWatchListStatus,
    required this.addMovieWatchlist,
    required this.deleteMovieWatchlist,
  });

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  RequestState _movieState = RequestState.empty;
  RequestState get movieState => _movieState;

  List<Movie> _movieRecommendations = <Movie>[];
  List<Movie> get movieRecommendations => _movieRecommendations;

  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.loading;
    notifyListeners();

    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _message = failure.message;
        _movieState = RequestState.error;
        notifyListeners();
      },
      (movie) {
        _movie = movie;
        _recommendationState = RequestState.loading;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _message = failure.message;
            _recommendationState = RequestState.error;
          },
          (movies) {
            _movieRecommendations = movies;
            _recommendationState = RequestState.loaded;
          },
        );

        _movieState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> addMovieToWatchlist(MovieDetail movie) async {
    final result = await addMovieWatchlist.execute(movie);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (successMessage) async => _watchlistMessage = successMessage,
    );

    await loadMovieWatchlistStatus(movie.id);
  }

  Future<void> removeMovieFromWatchlist(MovieDetail movie) async {
    final result = await deleteMovieWatchlist.execute(movie);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (successMessage) async => _watchlistMessage = successMessage,
    );

    await loadMovieWatchlistStatus(movie.id);
  }

  Future<void> loadMovieWatchlistStatus(int id) async {
    final result = await getMovieWatchListStatus.execute(id);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (isAdded) async => _isAddedtoWatchlist = isAdded,
    );

    notifyListeners();
  }
}
