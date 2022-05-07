import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import '../widgets/movie_detail_content_test.mocks.dart';

void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() => mockNotifier = MockMovieDetailNotifier());

  Widget _makeTestableWidget(Widget widget) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: widget,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (WidgetTester tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.loading);

      final centerFinder = find.byType(Center);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(
        _makeTestableWidget(const MovieDetailPage(id: 1)),
      );

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display MovieDetailContent when data is loaded',
    (WidgetTester tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);

      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);

      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      final typeFinder = find.byType(MovieDetailContent);

      await tester.pumpWidget(
        _makeTestableWidget(const MovieDetailPage(id: 1)),
      );

      expect(typeFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (WidgetTester tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(
        _makeTestableWidget(const MovieDetailPage(id: 1)),
      );

      expect(textFinder, findsOneWidget);
    },
  );
}
