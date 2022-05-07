import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/presentation/pages/tv_shows_page.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_list_notifier.dart';
import 'package:ditonton/presentation/widgets/item_list.dart';
import 'package:ditonton/presentation/widgets/subheading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_shows_page_test.mocks.dart';

@GenerateMocks([TvShowListNotifier])
void main() {
  late MockTvShowListNotifier mockNotifier;

  setUp(() => mockNotifier = MockTvShowListNotifier());

  Widget _makeTestableWidget(Widget widget) {
    return ChangeNotifierProvider<TvShowListNotifier>.value(
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
      when(mockNotifier.onTheAirTvShowsState).thenReturn(RequestState.empty);
      when(mockNotifier.popularTvShowsState).thenReturn(RequestState.empty);
      when(mockNotifier.topRatedTvShowsState).thenReturn(RequestState.empty);

      final subHeadingFinder = find.byType(SubHeading);

      await tester.pumpWidget(_makeTestableWidget(const TvShowsPage()));

      expect(subHeadingFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (WidgetTester tester) async {
      when(mockNotifier.onTheAirTvShowsState).thenReturn(RequestState.loaded);
      when(mockNotifier.popularTvShowsState).thenReturn(RequestState.loaded);
      when(mockNotifier.topRatedTvShowsState).thenReturn(RequestState.loaded);

      when(mockNotifier.onTheAirTvShows).thenReturn(<TvShow>[testTvShow]);
      when(mockNotifier.popularTvShows).thenReturn(<TvShow>[testTvShow]);
      when(mockNotifier.topRatedTvShows).thenReturn(<TvShow>[testTvShow]);

      final listViewFinder = find.byType(ItemList);

      await tester.pumpWidget(_makeTestableWidget(const TvShowsPage()));

      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (WidgetTester tester) async {
      when(mockNotifier.onTheAirTvShowsState).thenReturn(RequestState.error);
      when(mockNotifier.popularTvShowsState).thenReturn(RequestState.error);
      when(mockNotifier.topRatedTvShowsState).thenReturn(RequestState.error);

      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const TvShowsPage()));

      expect(textFinder, findsNWidgets(3));
    },
  );
}
