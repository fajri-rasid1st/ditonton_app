import 'dart:async';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/movie_watchlist.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/data/models/tv_series_watchlist.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  late Database _database;

  Future<Database> get database async {
    _database = await _initializeDb('watchlist_database.db');

    return _database;
  }

  /// Initialize, create, and open database.
  Future<Database> _initializeDb(String file) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, file);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /// Create database table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $movieWatchlistTable (
        ${MovieWatchlistFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${MovieWatchlistFields.title} TEXT,
        ${MovieWatchlistFields.overview} TEXT,
        ${MovieWatchlistFields.posterPath} TEXT)
        ''');

    await db.execute('''
      CREATE TABLE $tvSeriesWatchlistTable (
        ${TvSeriesWatchlistFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TvSeriesWatchlistFields.name} TEXT,
        ${TvSeriesWatchlistFields.overview} TEXT,
        ${TvSeriesWatchlistFields.posterPath} TEXT)
        ''');
  }

  Future<int> insertWatchlist(
    MovieTable? movie,
    TvSeriesTable? tvSeries,
  ) async {
    final db = await database;

    if (movie != null) {
      return await db.insert(movieWatchlistTable, movie.toJson());
    }

    return await db.insert(tvSeriesWatchlistTable, tvSeries!.toJson());
  }

  Future<int> removeWatchlist(
    MovieTable? movie,
    TvSeriesTable? tvSeries,
  ) async {
    final db = await database;

    if (movie != null) {
      return await db.delete(
        movieWatchlistTable,
        where: '${MovieWatchlistFields.id} = ?',
        whereArgs: [movie.id],
      );
    }

    return await db.delete(
      tvSeriesWatchlistTable,
      where: '${TvSeriesWatchlistFields.id} = ?',
      whereArgs: [tvSeries!.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieOrTvSeriesById(
    int id,
    String type,
  ) async {
    final db = await database;

    final watchlistTable = type.toLowerCase() == 'movie'
        ? movieWatchlistTable
        : tvSeriesWatchlistTable;

    final watchlistId = type.toLowerCase() == 'movie'
        ? MovieWatchlistFields.id
        : TvSeriesWatchlistFields.id;

    final results = await db.query(
      watchlistTable,
      where: '$watchlistId = ?',
      whereArgs: [id],
    );

    return results.isNotEmpty ? results.first : null;
  }

  Future<List<Map<String, dynamic>>> getWatchlist(String type) async {
    final db = await database;

    final watchlistTable = type.toLowerCase() == 'movie'
        ? movieWatchlistTable
        : tvSeriesWatchlistTable;

    final List<Map<String, dynamic>> results = await db.query(watchlistTable);

    return results;
  }
}
