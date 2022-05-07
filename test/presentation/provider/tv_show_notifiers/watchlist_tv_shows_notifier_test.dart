import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_watchlist_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/watchlist_tv_shows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_shows_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvShows])
void main() {
  late WatchlistTvShowsNotifier provider;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockGetWatchlistTvShows = MockGetWatchlistTvShows();

    provider = WatchlistTvShowsNotifier(
      getWatchlistTvShows: mockGetWatchlistTvShows,
    )..addListener(() => listenerCallCount++);
  });

  test('Should change tv shows data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetWatchlistTvShows.execute())
        .thenAnswer((_) async => const Right(<TvShow>[testWatchlistTvShow]));

    // act
    await provider.fetchWatchlistTvShows();

    // assert
    expect(provider.watchlistState, RequestState.loaded);
    expect(provider.watchlistTvShows, [testWatchlistTvShow]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTvShows.execute()).thenAnswer(
        (_) async => const Left(DatabaseFailure('Database Failure')));

    // act
    await provider.fetchWatchlistTvShows();

    // assert
    expect(provider.watchlistState, RequestState.error);
    expect(provider.message, 'Database Failure');
    expect(listenerCallCount, 2);
  });
}
