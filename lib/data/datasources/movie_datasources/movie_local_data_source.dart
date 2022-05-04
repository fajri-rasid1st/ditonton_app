import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertMovieWatchlist(MovieTable movie);

  Future<String> removeMovieWatchlist(MovieTable movie);

  Future<MovieTable?> getMovieById(int id);

  Future<List<MovieTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertMovieWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertMovieWatchlist(movie);

      return 'Added Movie to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeMovieWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeMovieWatchlist(movie);

      return 'Removed Movie from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    try {
      final result = await databaseHelper.getMovieById(id);

      if (result != null) return MovieTable.fromMap(result);

      return null;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    try {
      final result = await databaseHelper.getWatchlistMovies();

      return result.map((movie) => MovieTable.fromMap(movie)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
