import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_show_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_page_test.mocks.dart';

@GenerateMocks([TvShowDetailNotifier])
void main() {
  late MockTvShowDetailNotifier mockNotifier;

  setUp(() => mockNotifier = MockTvShowDetailNotifier());

  Widget _makeTestableWidget(Widget widget) {
    return ChangeNotifierProvider<TvShowDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: widget,
          ),
        ),
      ),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when tv show not added to watchlist',
    (WidgetTester tester) async {
      when(mockNotifier.tvShowState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvShow).thenReturn(testTvShowDetail);

      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);

      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      final watchlistButtonIcon = find.byIcon(Icons.add_rounded);

      await tester.pumpWidget(_makeTestableWidget(const TvShowDetailContent(
        tvShow: testTvShowDetail,
        tvShowRecommendations: <TvShow>[],
        isAddedWatchlist: false,
      )));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display check icon when tv show is added to wathclist',
    (WidgetTester tester) async {
      when(mockNotifier.tvShowState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvShow).thenReturn(testTvShowDetail);

      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);

      when(mockNotifier.isAddedToWatchlist).thenReturn(true);

      final watchlistButtonIcon = find.byIcon(Icons.check_rounded);

      await tester.pumpWidget(_makeTestableWidget(const TvShowDetailContent(
        tvShow: testTvShowDetail,
        tvShowRecommendations: <TvShow>[],
        isAddedWatchlist: true,
      )));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when added to watchlist successful',
    (WidgetTester tester) async {
      when(mockNotifier.tvShowState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvShow).thenReturn(testTvShowDetail);

      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);

      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage)
          .thenReturn('Added Tv Show to Watchlist');

      final watchlistButton = find.byKey(const Key('watchlist_button'));

      await tester.pumpWidget(_makeTestableWidget(const TvShowDetailContent(
        tvShow: testTvShowDetail,
        tvShowRecommendations: <TvShow>[],
        isAddedWatchlist: false,
      )));

      expect(find.byIcon(Icons.add_rounded), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added Tv Show to Watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display AlertDialog when add to watchlist failed',
    (WidgetTester tester) async {
      when(mockNotifier.tvShowState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvShow).thenReturn(testTvShowDetail);

      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);

      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Failed');

      final watchlistButton = find.byKey(const Key('watchlist_button'));

      await tester.pumpWidget(_makeTestableWidget(const TvShowDetailContent(
        tvShow: testTvShowDetail,
        tvShowRecommendations: <TvShow>[],
        isAddedWatchlist: false,
      )));

      expect(find.byIcon(Icons.add_rounded), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );
}
