// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/presentation/pages/tv_shows_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i8;
import 'dart:ui' as _i9;

import 'package:ditonton/common/state_enum.dart' as _i7;
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart' as _i6;
import 'package:ditonton/domain/usecases/tv_show_usecases/get_on_the_air_tv_shows.dart'
    as _i2;
import 'package:ditonton/domain/usecases/tv_show_usecases/get_popular_tv_shows.dart'
    as _i3;
import 'package:ditonton/domain/usecases/tv_show_usecases/get_top_rated_tv_shows.dart'
    as _i4;
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_list_notifier.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetOnTheAirTvShows_0 extends _i1.Fake
    implements _i2.GetOnTheAirTvShows {}

class _FakeGetPopularTvShows_1 extends _i1.Fake
    implements _i3.GetPopularTvShows {}

class _FakeGetTopRatedTvShows_2 extends _i1.Fake
    implements _i4.GetTopRatedTvShows {}

/// A class which mocks [TvShowListNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowListNotifier extends _i1.Mock
    implements _i5.TvShowListNotifier {
  MockTvShowListNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetOnTheAirTvShows get getOnTheAirTvShows =>
      (super.noSuchMethod(Invocation.getter(#getOnTheAirTvShows),
          returnValue: _FakeGetOnTheAirTvShows_0()) as _i2.GetOnTheAirTvShows);
  @override
  _i3.GetPopularTvShows get getPopularTvShows =>
      (super.noSuchMethod(Invocation.getter(#getPopularTvShows),
          returnValue: _FakeGetPopularTvShows_1()) as _i3.GetPopularTvShows);
  @override
  _i4.GetTopRatedTvShows get getTopRatedTvShows =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedTvShows),
          returnValue: _FakeGetTopRatedTvShows_2()) as _i4.GetTopRatedTvShows);
  @override
  List<_i6.TvShow> get onTheAirTvShows =>
      (super.noSuchMethod(Invocation.getter(#onTheAirTvShows),
          returnValue: <_i6.TvShow>[]) as List<_i6.TvShow>);
  @override
  _i7.RequestState get onTheAirTvShowsState =>
      (super.noSuchMethod(Invocation.getter(#onTheAirTvShowsState),
          returnValue: _i7.RequestState.empty) as _i7.RequestState);
  @override
  List<_i6.TvShow> get popularTvShows =>
      (super.noSuchMethod(Invocation.getter(#popularTvShows),
          returnValue: <_i6.TvShow>[]) as List<_i6.TvShow>);
  @override
  _i7.RequestState get popularTvShowsState =>
      (super.noSuchMethod(Invocation.getter(#popularTvShowsState),
          returnValue: _i7.RequestState.empty) as _i7.RequestState);
  @override
  List<_i6.TvShow> get topRatedTvShows =>
      (super.noSuchMethod(Invocation.getter(#topRatedTvShows),
          returnValue: <_i6.TvShow>[]) as List<_i6.TvShow>);
  @override
  _i7.RequestState get topRatedTvShowsState =>
      (super.noSuchMethod(Invocation.getter(#topRatedTvShowsState),
          returnValue: _i7.RequestState.empty) as _i7.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i8.Future<void> fetchOnTheAirTvShows() =>
      (super.noSuchMethod(Invocation.method(#fetchOnTheAirTvShows, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#fetchPopularTvShows, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#fetchTopRatedTvShows, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  void addListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}