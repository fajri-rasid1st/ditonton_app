import 'dart:async';

import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/movie_watchlist.dart';
import 'package:ditonton/data/models/tv_watchlist.dart';
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
    await db.execute(
        '''
      CREATE TABLE $movieWatchlistTable (
        ${MovieWatchlistFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${MovieWatchlistFields.title} TEXT,
        ${MovieWatchlistFields.overview} TEXT,
        ${MovieWatchlistFields.posterPath} TEXT)
        ''');

    await db.execute(
        '''
      CREATE TABLE $tvWatchlistTable (
        ${TvWatchlistFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TvWatchlistFields.name} TEXT,
        ${TvWatchlistFields.overview} TEXT,
        ${TvWatchlistFields.posterPath} TEXT)
        ''');
  }

  Future<int> insertMovieWatchlist(MovieTable movie) async {
    final db = await database;

    return await db.insert(movieWatchlistTable, movie.toJson());
  }

  Future<int> insertTvWatchlist(MovieTable movie) async {
    final db = await database;

    return await db.insert(movieWatchlistTable, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
