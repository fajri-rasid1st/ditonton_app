import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_show_table.dart';

abstract class TvShowLocalDataSource {
  Future<String> insertTvShowWatchlist(TvShowTable tvShow);

  Future<String> removeTvShowWatchlist(TvShowTable tvShow);

  Future<TvShowTable?> getTvShowById(int id);

  Future<List<TvShowTable>> getWatchlistTvShows();
}

class TvShowLocalDataSourceImpl implements TvShowLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvShowLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertTvShowWatchlist(TvShowTable tvShow) async {
    try {
      await databaseHelper.insertTvShowWatchlist(tvShow);

      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvShowWatchlist(TvShowTable tvShow) async {
    try {
      await databaseHelper.removeTvShowWatchlist(tvShow);

      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getTvShowById(id);

    if (result != null) return TvShowTable.fromMap(result);

    return null;
  }

  @override
  Future<List<TvShowTable>> getWatchlistTvShows() async {
    final result = await databaseHelper.getWatchlistTvShows();

    return result.map((tvShow) => TvShowTable.fromMap(tvShow)).toList();
  }
}
