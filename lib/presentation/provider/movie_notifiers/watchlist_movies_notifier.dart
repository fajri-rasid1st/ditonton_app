import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_watchlist_movies.dart';
import 'package:flutter/foundation.dart';

class WatchlistMoviesNotifier extends ChangeNotifier {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesNotifier({required this.getWatchlistMovies});

  List<Movie> _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  RequestState _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _watchlistState = RequestState.error;
        notifyListeners();
      },
      (moviesData) {
        _watchlistMovies = moviesData;
        _watchlistState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
