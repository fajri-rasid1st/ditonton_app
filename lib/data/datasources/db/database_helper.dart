// coverage:ignore-file

import 'dart:async';
import 'package:ditonton/common/encrypt.dart';
import 'package:path/path.dart';
import 'package:ditonton/data/models/movie_models/movie_table.dart';
import 'package:ditonton/data/models/movie_models/movie_watchlist.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_table.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_watchlist.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

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

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('db_password'),
    );
  }

  /// Create database table.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $movieWatchlistTable (
        ${MovieWatchlistFields.id} INTEGER PRIMARY KEY,
        ${MovieWatchlistFields.title} TEXT,
        ${MovieWatchlistFields.overview} TEXT,
        ${MovieWatchlistFields.posterPath} TEXT,
        ${MovieWatchlistFields.createdAt} TEXT NOT NULL)
        ''');

    await db.execute('''
      CREATE TABLE $tvShowWatchlistTable (
        ${TvShowWatchlistFields.id} INTEGER PRIMARY KEY,
        ${TvShowWatchlistFields.name} TEXT,
        ${TvShowWatchlistFields.overview} TEXT,
        ${TvShowWatchlistFields.posterPath} TEXT,
        ${TvShowWatchlistFields.createdAt} TEXT NOT NULL)
        ''');
  }

  Future<int> insertMovieWatchlist(MovieTable movie) async {
    final db = await database;

    return await db.insert(movieWatchlistTable, movie.toJson());
  }

  Future<int> insertTvShowWatchlist(TvShowTable tvShow) async {
    final db = await database;

    return await db.insert(tvShowWatchlistTable, tvShow.toJson());
  }

  Future<int> removeMovieWatchlist(MovieTable movie) async {
    final db = await database;

    return await db.delete(
      movieWatchlistTable,
      where: '${MovieWatchlistFields.id} = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> removeTvShowWatchlist(TvShowTable tvShow) async {
    final db = await database;

    return await db.delete(
      tvShowWatchlistTable,
      where: '${TvShowWatchlistFields.id} = ?',
      whereArgs: [tvShow.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;

    final results = await db.query(
      movieWatchlistTable,
      where: '${MovieWatchlistFields.id} = ?',
      whereArgs: [id],
    );

    return results.isNotEmpty ? results.first : null;
  }

  Future<Map<String, dynamic>?> getTvShowById(int id) async {
    final db = await database;

    final results = await db.query(
      tvShowWatchlistTable,
      where: '${TvShowWatchlistFields.id} = ?',
      whereArgs: [id],
    );

    return results.isNotEmpty ? results.first : null;
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;

    return await db.query(
      movieWatchlistTable,
      orderBy: '${MovieWatchlistFields.createdAt} DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvShows() async {
    final db = await database;

    return await db.query(
      tvShowWatchlistTable,
      orderBy: '${TvShowWatchlistFields.createdAt} DESC',
    );
  }
}
