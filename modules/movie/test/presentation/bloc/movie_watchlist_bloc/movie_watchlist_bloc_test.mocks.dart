// Mocks generated by Mockito 5.1.0 from annotations
// in movie/test/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:core/utils/failure.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/movie.dart' as _i3;

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

/// A class which mocks [GetMovieWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieWatchListStatus extends _i1.Mock
    implements _i3.GetMovieWatchListStatus {
  MockGetMovieWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i2.Either<_i5.Failure, bool>>.value(
                  _FakeEither_0<_i5.Failure, bool>()))
          as _i4.Future<_i2.Either<_i5.Failure, bool>>);
}

/// A class which mocks [AddMovieWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddMovieWatchlist extends _i1.Mock implements _i3.AddMovieWatchlist {
  MockAddMovieWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> execute(_i3.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i4.Future<_i2.Either<_i5.Failure, String>>);
}

/// A class which mocks [DeleteMovieWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteMovieWatchlist extends _i1.Mock
    implements _i3.DeleteMovieWatchlist {
  MockDeleteMovieWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> execute(_i3.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i4.Future<_i2.Either<_i5.Failure, String>>);
}