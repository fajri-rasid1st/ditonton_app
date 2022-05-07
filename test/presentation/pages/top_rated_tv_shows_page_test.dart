import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/top_rated_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/list_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedTvShowsNotifier])
void main() {
  // late MockTopRatedMoviesNotifier mockNotifier;

  // setUp(() {
  //   mockNotifier = MockTopRatedMoviesNotifier();
  // });

  // Widget _makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<TopRatedMoviesNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }

  // testWidgets(
  //   'Page should display center progress bar when loading',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.state).thenReturn(RequestState.loading);

  //     final centerFinder = find.byType(Center);
  //     final progressFinder = find.byType(CircularProgressIndicator);

  //     await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

  //     expect(centerFinder, findsOneWidget);
  //     expect(progressFinder, findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   'Page should display ListView when data is loaded',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.state).thenReturn(RequestState.loaded);
  //     when(mockNotifier.movies).thenReturn(<Movie>[]);

  //     final listViewFinder = find.byType(ListCardItem);

  //     await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

  //     expect(listViewFinder, findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   'Page should display text with message when Error',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.state).thenReturn(RequestState.error);
  //     when(mockNotifier.message).thenReturn('Error message');

  //     final textFinder = find.byKey(const Key('error_message'));

  //     await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

  //     expect(textFinder, findsOneWidget);
  //   },
  // );
}
