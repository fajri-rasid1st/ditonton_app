import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/presentation/pages/movies_page.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_list_notifier.dart';
import 'package:ditonton/presentation/widgets/item_list.dart';
import 'package:ditonton/presentation/widgets/subheading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movies_page_test.mocks.dart';

@GenerateMocks([MovieListNotifier])
void main() {
  late MockMovieListNotifier mockNotifier;

  setUp(() => mockNotifier = MockMovieListNotifier());

  Widget _makeTestableWidget(Widget widget) {
    return ChangeNotifierProvider<MovieListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(child: widget),
        ),
      ),
    );
  }

  testWidgets(
    'Page should display three sub heading when first launch',
    (WidgetTester tester) async {
      when(mockNotifier.nowPlayingMovieState).thenReturn(RequestState.empty);
      when(mockNotifier.popularMoviesState).thenReturn(RequestState.empty);
      when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.empty);

      final subHeadingFinder = find.byType(SubHeading);

      await tester.pumpWidget(_makeTestableWidget(const MoviesPage()));

      expect(subHeadingFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (WidgetTester tester) async {
      when(mockNotifier.nowPlayingMovieState).thenReturn(RequestState.loaded);
      when(mockNotifier.popularMoviesState).thenReturn(RequestState.loaded);
      when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.loaded);

      when(mockNotifier.nowPlayingMovies).thenReturn(<Movie>[testMovie]);
      when(mockNotifier.popularMovies).thenReturn(<Movie>[testMovie]);
      when(mockNotifier.topRatedMovies).thenReturn(<Movie>[testMovie]);

      final listViewFinder = find.byType(ItemList);

      await tester.pumpWidget(_makeTestableWidget(const MoviesPage()));

      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (WidgetTester tester) async {
      when(mockNotifier.nowPlayingMovieState).thenReturn(RequestState.error);
      when(mockNotifier.popularMoviesState).thenReturn(RequestState.error);
      when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.error);

      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const MoviesPage()));

      expect(textFinder, findsNWidgets(3));
    },
  );
}
