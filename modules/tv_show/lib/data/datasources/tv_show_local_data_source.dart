import 'package:core/utils/exception.dart';
import 'package:database/database.dart';
import 'package:tv_show/data/models/tv_show_table.dart';

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

      return 'Added Tv Show to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvShowWatchlist(TvShowTable tvShow) async {
    try {
      await databaseHelper.removeTvShowWatchlist(tvShow);

      return 'Removed Tv Show from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    try {
      final result = await databaseHelper.getTvShowById(id);

      if (result != null) return TvShowTable.fromMap(result);

      return null;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TvShowTable>> getWatchlistTvShows() async {
    try {
      final result = await databaseHelper.getWatchlistTvShows();

      return result.map((tvShow) => TvShowTable.fromMap(tvShow)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
