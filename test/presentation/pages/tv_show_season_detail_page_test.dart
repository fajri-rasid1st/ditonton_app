import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/presentation/pages/tv_show_season_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_episodes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_season_detail_page_test.mocks.dart';

@GenerateMocks([TvShowEpisodesNotifier])
void main() {
  late MockTvShowEpisodesNotifier mockNotifier;

  setUp(() => mockNotifier = MockTvShowEpisodesNotifier());

  Widget _makeTestableWidget(Widget widget) {
    return ChangeNotifierProvider<TvShowEpisodesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: widget,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loading);

      final centerFinder = find.byType(Center);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(
        const TvShowSeasonDetailPage(tvShowId: 1, season: testSeason),
      ));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display SliverAppBar when data is loaded',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.episodes).thenReturn(<Episode>[testEpisode]);

      final appBarFinder = find.byType(SliverAppBar);

      await tester.pumpWidget(_makeTestableWidget(
        const TvShowSeasonDetailPage(tvShowId: 1, season: testSeason),
      ));

      expect(appBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.episodes).thenReturn(<Episode>[testEpisode]);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(
        const TvShowSeasonDetailPage(tvShowId: 1, season: testSeason),
      ));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(
        const TvShowSeasonDetailPage(tvShowId: 1, season: testSeason),
      ));

      expect(textFinder, findsOneWidget);
    },
  );
}
