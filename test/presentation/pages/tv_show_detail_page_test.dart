import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([TvShowDetailNotifier])
void main() {
  // late MockMovieDetailNotifier mockNotifier;

  // setUp(() => mockNotifier = MockMovieDetailNotifier());

  // Widget _makeTestableWidget(Widget widget) {
  //   return ChangeNotifierProvider<MovieDetailNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: Scaffold(
  //         body: SafeArea(
  //           child: widget,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // testWidgets(
  //   'Watchlist button should display add icon when movie not added to watchlist',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.movieState).thenReturn(RequestState.loaded);
  //     when(mockNotifier.movie).thenReturn(testMovieDetail);

  //     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);

  //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);

  //     final watchlistButtonIcon = find.byIcon(Icons.add_rounded);

  //     await tester.pumpWidget(_makeTestableWidget(const MovieDetailContent(
  //       movie: testMovieDetail,
  //       movieRecommendations: <Movie>[],
  //       isAddedWatchlist: false,
  //     )));

  //     expect(watchlistButtonIcon, findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   'Watchlist button should display check icon when movie is added to wathclist',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.movieState).thenReturn(RequestState.loaded);
  //     when(mockNotifier.movie).thenReturn(testMovieDetail);

  //     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);

  //     when(mockNotifier.isAddedToWatchlist).thenReturn(true);

  //     final watchlistButtonIcon = find.byIcon(Icons.check_rounded);

  //     await tester.pumpWidget(_makeTestableWidget(const MovieDetailContent(
  //       movie: testMovieDetail,
  //       movieRecommendations: <Movie>[],
  //       isAddedWatchlist: true,
  //     )));

  //     expect(watchlistButtonIcon, findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   'Watchlist button should display Snackbar when added to watchlist',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.movieState).thenReturn(RequestState.loaded);
  //     when(mockNotifier.movie).thenReturn(testMovieDetail);

  //     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);

  //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //     when(mockNotifier.watchlistMessage)
  //         .thenReturn('Added Movie to Watchlist');

  //     final watchlistButton = find.byKey(const Key('watchlist_button'));

  //     await tester.pumpWidget(_makeTestableWidget(const MovieDetailContent(
  //       movie: testMovieDetail,
  //       movieRecommendations: <Movie>[],
  //       isAddedWatchlist: false,
  //     )));

  //     expect(find.byIcon(Icons.add_rounded), findsOneWidget);

  //     await tester.tap(watchlistButton);
  //     await tester.pump();

  //     expect(find.byType(SnackBar), findsOneWidget);
  //     expect(find.text('Added Movie to Watchlist'), findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   'Watchlist button should display AlertDialog when add to watchlist failed',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.movieState).thenReturn(RequestState.loaded);
  //     when(mockNotifier.movie).thenReturn(testMovieDetail);

  //     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);

  //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //     when(mockNotifier.watchlistMessage).thenReturn('Failed');

  //     final watchlistButton = find.byKey(const Key('watchlist_button'));

  //     await tester.pumpWidget(_makeTestableWidget(const MovieDetailContent(
  //       movie: testMovieDetail,
  //       movieRecommendations: <Movie>[],
  //       isAddedWatchlist: false,
  //     )));

  //     expect(find.byIcon(Icons.add_rounded), findsOneWidget);

  //     await tester.tap(watchlistButton);
  //     await tester.pump();

  //     expect(find.byType(AlertDialog), findsOneWidget);
  //     expect(find.text('Failed'), findsOneWidget);
  //   },
  // );
}
