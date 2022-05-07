import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/presentation/pages/on_the_air_tv_shows_page.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/on_the_air_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/list_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_the_air_tv_shows_page_test.mocks.dart';

@GenerateMocks([OnTheAirTvShowsNotifier])
void main() {
  late MockOnTheAirTvShowsNotifier mockNotifier;

  setUp(() => mockNotifier = MockOnTheAirTvShowsNotifier());

  Widget _makeTestableWidget(Widget widget) {
    return ChangeNotifierProvider<OnTheAirTvShowsNotifier>.value(
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

      await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvShowsPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.tvShows).thenReturn(<TvShow>[testTvShow]);

      final listViewFinder = find.byType(ListCardItem);

      await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvShowsPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvShowsPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
