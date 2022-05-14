// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i8;
import 'dart:convert' as _i26;
import 'dart:typed_data' as _i27;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i9;
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i25;
import 'package:ditonton/data/datasources/movie_datasources/movie_local_data_source.dart'
    as _i14;
import 'package:ditonton/data/datasources/movie_datasources/movie_remote_data_source.dart'
    as _i12;
import 'package:ditonton/data/datasources/tv_show_datasources/tv_show_local_data_source.dart'
    as _i23;
import 'package:ditonton/data/datasources/tv_show_datasources/tv_show_remote_data_source.dart'
    as _i20;
import 'package:ditonton/data/models/episode_model.dart' as _i22;
import 'package:ditonton/data/models/movie_models/movie_detail_model.dart'
    as _i3;
import 'package:ditonton/data/models/movie_models/movie_model.dart' as _i13;
import 'package:ditonton/data/models/movie_models/movie_table.dart' as _i15;
import 'package:ditonton/data/models/tv_show_models/tv_show_detail_model.dart'
    as _i4;
import 'package:ditonton/data/models/tv_show_models/tv_show_model.dart' as _i21;
import 'package:ditonton/data/models/tv_show_models/tv_show_table.dart' as _i24;
import 'package:ditonton/domain/entities/episode.dart' as _i19;
import 'package:ditonton/domain/entities/movie_entities/movie.dart' as _i10;
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart'
    as _i11;
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart' as _i17;
import 'package:ditonton/domain/entities/tv_show_entities/tv_show_detail.dart'
    as _i18;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_show_repository.dart' as _i16;
import 'package:http/http.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieDetailModel_1 extends _i1.Fake implements _i3.MovieDetailModel {
}

class _FakeTvShowDetailModel_2 extends _i1.Fake
    implements _i4.TvShowDetailModel {}

class _FakeDatabase_3 extends _i1.Fake implements _i5.Database {}

class _FakeResponse_4 extends _i1.Fake implements _i6.Response {}

class _FakeStreamedResponse_5 extends _i1.Fake implements _i6.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i7.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, _i11.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i9.Failure, _i11.MovieDetail>>.value(
              _FakeEither_0<_i9.Failure, _i11.MovieDetail>())) as _i8
          .Future<_i2.Either<_i9.Failure, _i11.MovieDetail>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> addMovieWatchlist(
          _i11.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#addMovieWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>()))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> deleteMovieWatchlist(
          _i11.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#deleteMovieWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>()))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, bool>> isMovieAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isMovieAddedToWatchlist, [id]),
              returnValue: Future<_i2.Either<_i9.Failure, bool>>.value(
                  _FakeEither_0<_i9.Failure, bool>()))
          as _i8.Future<_i2.Either<_i9.Failure, bool>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i12.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i13.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]))
          as _i8.Future<List<_i13.MovieModel>>);
  @override
  _i8.Future<List<_i13.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]))
      as _i8.Future<List<_i13.MovieModel>>);
  @override
  _i8.Future<List<_i13.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]))
      as _i8.Future<List<_i13.MovieModel>>);
  @override
  _i8.Future<_i3.MovieDetailModel> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue:
                  Future<_i3.MovieDetailModel>.value(_FakeMovieDetailModel_1()))
          as _i8.Future<_i3.MovieDetailModel>);
  @override
  _i8.Future<List<_i13.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]))
          as _i8.Future<List<_i13.MovieModel>>);
  @override
  _i8.Future<List<_i13.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]))
          as _i8.Future<List<_i13.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i14.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<String> insertMovieWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertMovieWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<String> removeMovieWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeMovieWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<_i15.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i15.MovieTable?>.value())
          as _i8.Future<_i15.MovieTable?>);
  @override
  _i8.Future<List<_i15.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i15.MovieTable>>.value(<_i15.MovieTable>[]))
      as _i8.Future<List<_i15.MovieTable>>);
}

/// A class which mocks [TvShowRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRepository extends _i1.Mock implements _i16.TvShowRepository {
  MockTvShowRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>> getOnTheAirTvShows() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTvShows, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, _i18.TvShowDetail>> getTvShowDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
          returnValue: Future<_i2.Either<_i9.Failure, _i18.TvShowDetail>>.value(
              _FakeEither_0<_i9.Failure, _i18.TvShowDetail>())) as _i8
          .Future<_i2.Either<_i9.Failure, _i18.TvShowDetail>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>
      getTvShowRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getTvShowRecommendations, [id]),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>> searchTvShows(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i19.Episode>>> getTvShowEpisodes(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#getTvShowEpisodes, [id, seasonNumber]),
              returnValue:
                  Future<_i2.Either<_i9.Failure, List<_i19.Episode>>>.value(
                      _FakeEither_0<_i9.Failure, List<_i19.Episode>>()))
          as _i8.Future<_i2.Either<_i9.Failure, List<_i19.Episode>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> addTvShowWatchlist(
          _i18.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#addTvShowWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>()))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> deleteTvShowWatchlist(
          _i18.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#deleteTvShowWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>()))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, bool>> isTvShowAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isTvShowAddedToWatchlist, [id]),
              returnValue: Future<_i2.Either<_i9.Failure, bool>>.value(
                  _FakeEither_0<_i9.Failure, bool>()))
          as _i8.Future<_i2.Either<_i9.Failure, bool>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>
      getWatchlistTvShows() => (super.noSuchMethod(
          Invocation.method(#getWatchlistTvShows, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TvShow>>>);
}

/// A class which mocks [TvShowRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRemoteDataSource extends _i1.Mock
    implements _i20.TvShowRemoteDataSource {
  MockTvShowRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i21.TvShowModel>> getOnTheAirTvShows() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTvShows, []),
              returnValue:
                  Future<List<_i21.TvShowModel>>.value(<_i21.TvShowModel>[]))
          as _i8.Future<List<_i21.TvShowModel>>);
  @override
  _i8.Future<List<_i21.TvShowModel>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
              returnValue:
                  Future<List<_i21.TvShowModel>>.value(<_i21.TvShowModel>[]))
          as _i8.Future<List<_i21.TvShowModel>>);
  @override
  _i8.Future<List<_i21.TvShowModel>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
              returnValue:
                  Future<List<_i21.TvShowModel>>.value(<_i21.TvShowModel>[]))
          as _i8.Future<List<_i21.TvShowModel>>);
  @override
  _i8.Future<_i4.TvShowDetailModel> getTvShowDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
              returnValue: Future<_i4.TvShowDetailModel>.value(
                  _FakeTvShowDetailModel_2()))
          as _i8.Future<_i4.TvShowDetailModel>);
  @override
  _i8.Future<List<_i21.TvShowModel>> getTvShowRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowRecommendations, [id]),
              returnValue:
                  Future<List<_i21.TvShowModel>>.value(<_i21.TvShowModel>[]))
          as _i8.Future<List<_i21.TvShowModel>>);
  @override
  _i8.Future<List<_i21.TvShowModel>> searchTvShows(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
              returnValue:
                  Future<List<_i21.TvShowModel>>.value(<_i21.TvShowModel>[]))
          as _i8.Future<List<_i21.TvShowModel>>);
  @override
  _i8.Future<List<_i22.EpisodeModel>> getTvShowEpisodes(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#getTvShowEpisodes, [id, seasonNumber]),
              returnValue:
                  Future<List<_i22.EpisodeModel>>.value(<_i22.EpisodeModel>[]))
          as _i8.Future<List<_i22.EpisodeModel>>);
}

/// A class which mocks [TvShowLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowLocalDataSource extends _i1.Mock
    implements _i23.TvShowLocalDataSource {
  MockTvShowLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<String> insertTvShowWatchlist(_i24.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertTvShowWatchlist, [tvShow]),
          returnValue: Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<String> removeTvShowWatchlist(_i24.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeTvShowWatchlist, [tvShow]),
          returnValue: Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<_i24.TvShowTable?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<_i24.TvShowTable?>.value())
          as _i8.Future<_i24.TvShowTable?>);
  @override
  _i8.Future<List<_i24.TvShowTable>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue:
                  Future<List<_i24.TvShowTable>>.value(<_i24.TvShowTable>[]))
          as _i8.Future<List<_i24.TvShowTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i25.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i5.Database> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i5.Database>.value(_FakeDatabase_3()))
          as _i8.Future<_i5.Database>);
  @override
  _i8.Future<int> insertMovieWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertMovieWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> insertTvShowWatchlist(_i24.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertTvShowWatchlist, [tvShow]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> removeMovieWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeMovieWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> removeTvShowWatchlist(_i24.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeTvShowWatchlist, [tvShow]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i8.Future<Map<String, dynamic>?>);
  @override
  _i8.Future<Map<String, dynamic>?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i8.Future<Map<String, dynamic>?>);
  @override
  _i8.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i8.Future<List<Map<String, dynamic>>>);
  @override
  _i8.Future<List<Map<String, dynamic>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i8.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i6.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i6.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i26.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i26.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i26.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i26.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i8.Future<_i6.Response>);
  @override
  _i8.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<_i27.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i27.Uint8List>.value(_i27.Uint8List(0)))
          as _i8.Future<_i27.Uint8List>);
  @override
  _i8.Future<_i6.StreamedResponse> send(_i6.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i6.StreamedResponse>.value(_FakeStreamedResponse_5()))
          as _i8.Future<_i6.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}