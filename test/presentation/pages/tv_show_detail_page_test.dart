import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_show_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import '../widgets/tv_show_detail_content_test.mocks.dart';

void main() {
  late MockTvShowDetailNotifier mockNotifier;

  setUp(() => mockNotifier = MockTvShowDetailNotifier());

  Widget _makeTestableWidget(Widget widget) {
    return ChangeNotifierProvider<TvShowDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: widget,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (WidgetTester tester) async {
      when(mockNotifier.tvShowState).thenReturn(RequestState.loading);

      final centerFinder = find.byType(Center);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(
        _makeTestableWidget(const TvShowDetailPage(id: 1)),
      );

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display TvShowDetailContent when data is loaded',
    (WidgetTester tester) async {
      when(mockNotifier.tvShowState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvShow).thenReturn(testTvShowDetail);

      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);

      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      final typeFinder = find.byType(TvShowDetailContent);

      await tester.pumpWidget(
        _makeTestableWidget(const TvShowDetailPage(id: 1)),
      );

      expect(typeFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (WidgetTester tester) async {
      when(mockNotifier.tvShowState).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(
        _makeTestableWidget(const TvShowDetailPage(id: 1)),
      );

      expect(textFinder, findsOneWidget);
    },
  );
}
