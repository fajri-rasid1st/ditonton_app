import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/watchlist_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMoviesNotifier provider;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockGetWatchlistMovies = MockGetWatchlistMovies();

    provider = WatchlistMoviesNotifier(
      getWatchlistMovies: mockGetWatchlistMovies,
    )..addListener(() => listenerCallCount++);
  });

  test('Should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistMovies.execute())
        .thenAnswer((_) async => const Right(<Movie>[testWatchlistMovie]));

    // act
    await provider.fetchWatchlistMovies();

    // assert
    expect(provider.watchlistState, RequestState.loaded);
    expect(provider.watchlistMovies, [testWatchlistMovie]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistMovies.execute()).thenAnswer(
        (_) async => const Left(DatabaseFailure('Database Failure')));

    // act
    await provider.fetchWatchlistMovies();

    // assert
    expect(provider.watchlistState, RequestState.error);
    expect(provider.message, 'Database Failure');
    expect(listenerCallCount, 2);
  });
}
