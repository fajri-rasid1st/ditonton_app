import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_watchlist_tv_shows.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_shows_bloc/watchlist_tv_shows_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvShows])
void main() {
  late WatchlistTvShowsBloc watchlistTvShowsBloc;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;

  setUp(() {
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    watchlistTvShowsBloc = WatchlistTvShowsBloc(
      getWatchlistTvShows: mockGetWatchlistTvShows,
    );
  });

  test('Initial state should be empty', () {
    expect(watchlistTvShowsBloc.state, WatchlistTvShowsEmpty());
  });

  blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => const Right(<TvShow>[testWatchlistTvShow]));

      return watchlistTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvShows()),
    expect: () => [
      WatchlistTvShowsLoading(),
      const WatchlistTvShowsHasData(<TvShow>[testWatchlistTvShow]),
    ],
    verify: (_) => verify(mockGetWatchlistTvShows.execute()),
  );

  blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvShows.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));

      return watchlistTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvShows()),
    expect: () => [
      WatchlistTvShowsLoading(),
      const WatchlistTvShowsError('Database Failure'),
    ],
    verify: (_) => verify(mockGetWatchlistTvShows.execute()),
  );
}
