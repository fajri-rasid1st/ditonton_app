// Mocks generated by Mockito 5.1.0 from annotations
// in tv_show/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:convert' as _i10;
import 'dart:typed_data' as _i11;

import 'package:core/utils/failure.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:database/database.dart' as _i8;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/data/models/movie_table.dart' as _i9;
import 'package:sqflite_sqlcipher/sqflite.dart' as _i4;
import 'package:tv_show/tvshow.dart' as _i3;

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

class _FakeTvShowDetailModel_1 extends _i1.Fake
    implements _i3.TvShowDetailModel {}

class _FakeDatabase_2 extends _i1.Fake implements _i4.Database {}

class _FakeResponse_3 extends _i1.Fake implements _i5.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i5.StreamedResponse {
}

/// A class which mocks [TvShowRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRepository extends _i1.Mock implements _i3.TvShowRepository {
  MockTvShowRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>> getOnTheAirTvShows() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTvShows, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i3.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i3.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i3.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i3.TvShowDetail>> getTvShowDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, _i3.TvShowDetail>>.value(
              _FakeEither_0<_i7.Failure, _i3.TvShowDetail>())) as _i6
          .Future<_i2.Either<_i7.Failure, _i3.TvShowDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>
      getTvShowRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getTvShowRecommendations, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i3.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>> searchTvShows(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i3.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i3.Episode>>> getTvShowEpisodes(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
          Invocation.method(#getTvShowEpisodes, [id, seasonNumber]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i3.Episode>>>.value(
              _FakeEither_0<_i7.Failure, List<_i3.Episode>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i3.Episode>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> addTvShowWatchlist(
          _i3.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#addTvShowWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> deleteTvShowWatchlist(
          _i3.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#deleteTvShowWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, bool>> isTvShowAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isTvShowAddedToWatchlist, [id]),
              returnValue: Future<_i2.Either<_i7.Failure, bool>>.value(
                  _FakeEither_0<_i7.Failure, bool>()))
          as _i6.Future<_i2.Either<_i7.Failure, bool>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i3.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i3.TvShow>>>);
}

/// A class which mocks [TvShowRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRemoteDataSource extends _i1.Mock
    implements _i3.TvShowRemoteDataSource {
  MockTvShowRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i3.TvShowModel>> getOnTheAirTvShows() => (super.noSuchMethod(
          Invocation.method(#getOnTheAirTvShows, []),
          returnValue: Future<List<_i3.TvShowModel>>.value(<_i3.TvShowModel>[]))
      as _i6.Future<List<_i3.TvShowModel>>);
  @override
  _i6.Future<List<_i3.TvShowModel>> getPopularTvShows() => (super.noSuchMethod(
          Invocation.method(#getPopularTvShows, []),
          returnValue: Future<List<_i3.TvShowModel>>.value(<_i3.TvShowModel>[]))
      as _i6.Future<List<_i3.TvShowModel>>);
  @override
  _i6.Future<List<_i3.TvShowModel>> getTopRatedTvShows() => (super.noSuchMethod(
          Invocation.method(#getTopRatedTvShows, []),
          returnValue: Future<List<_i3.TvShowModel>>.value(<_i3.TvShowModel>[]))
      as _i6.Future<List<_i3.TvShowModel>>);
  @override
  _i6.Future<_i3.TvShowDetailModel> getTvShowDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
              returnValue: Future<_i3.TvShowDetailModel>.value(
                  _FakeTvShowDetailModel_1()))
          as _i6.Future<_i3.TvShowDetailModel>);
  @override
  _i6.Future<List<_i3.TvShowModel>> getTvShowRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowRecommendations, [id]),
              returnValue:
                  Future<List<_i3.TvShowModel>>.value(<_i3.TvShowModel>[]))
          as _i6.Future<List<_i3.TvShowModel>>);
  @override
  _i6.Future<List<_i3.TvShowModel>> searchTvShows(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
              returnValue:
                  Future<List<_i3.TvShowModel>>.value(<_i3.TvShowModel>[]))
          as _i6.Future<List<_i3.TvShowModel>>);
  @override
  _i6.Future<List<_i3.EpisodeModel>> getTvShowEpisodes(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#getTvShowEpisodes, [id, seasonNumber]),
              returnValue:
                  Future<List<_i3.EpisodeModel>>.value(<_i3.EpisodeModel>[]))
          as _i6.Future<List<_i3.EpisodeModel>>);
}

/// A class which mocks [TvShowLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowLocalDataSource extends _i1.Mock
    implements _i3.TvShowLocalDataSource {
  MockTvShowLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertTvShowWatchlist(_i3.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertTvShowWatchlist, [tvShow]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<String> removeTvShowWatchlist(_i3.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeTvShowWatchlist, [tvShow]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i3.TvShowTable?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<_i3.TvShowTable?>.value())
          as _i6.Future<_i3.TvShowTable?>);
  @override
  _i6.Future<List<_i3.TvShowTable>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue:
                  Future<List<_i3.TvShowTable>>.value(<_i3.TvShowTable>[]))
          as _i6.Future<List<_i3.TvShowTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i8.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Database> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i4.Database>.value(_FakeDatabase_2()))
          as _i6.Future<_i4.Database>);
  @override
  _i6.Future<int> insertMovieWatchlist(_i9.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertMovieWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> insertTvShowWatchlist(_i3.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertTvShowWatchlist, [tvShow]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> removeMovieWatchlist(_i9.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeMovieWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> removeTvShowWatchlist(_i3.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeTvShowWatchlist, [tvShow]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<Map<String, dynamic>?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i6.Future<List<Map<String, dynamic>>>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i6.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i10.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i10.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i10.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i10.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i6.Future<_i5.Response>);
  @override
  _i6.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i11.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i11.Uint8List>.value(_i11.Uint8List(0)))
          as _i6.Future<_i11.Uint8List>);
  @override
  _i6.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i6.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
