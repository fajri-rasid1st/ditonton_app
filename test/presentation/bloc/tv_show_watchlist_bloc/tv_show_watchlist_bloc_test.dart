import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/add_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/delete_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/tv_show_watchlist_bloc/tv_show_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvShowWatchListStatus,
  AddTvShowWatchlist,
  DeleteTvShowWatchlist,
])
void main() {
  late TvShowWatchlistBloc tvShowWatchlistBloc;
  late MockGetTvShowWatchListStatus mockGetTvShowWatchListStatus;
  late MockAddTvShowWatchlist mockAddTvShowWatchlist;
  late MockDeleteTvShowWatchlist mockDeleteTvShowWatchlist;

  const tId = 1;

  setUp(() {
    mockGetTvShowWatchListStatus = MockGetTvShowWatchListStatus();
    mockAddTvShowWatchlist = MockAddTvShowWatchlist();
    mockDeleteTvShowWatchlist = MockDeleteTvShowWatchlist();
    tvShowWatchlistBloc = TvShowWatchlistBloc(
      getTvShowWatchListStatus: mockGetTvShowWatchListStatus,
      addTvShowWatchlist: mockAddTvShowWatchlist,
      deleteTvShowWatchlist: mockDeleteTvShowWatchlist,
    );
  });

  test('Initial state should be empty', () {
    expect(tvShowWatchlistBloc.state, TvShowWatchlistStatusEmpty());
  });

  group('Tv show watchlist status test', () {
    blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
      'Should emit HasData when tv show watchlist status is gotten successfully',
      build: () {
        when(mockGetTvShowWatchListStatus.execute(tId))
            .thenAnswer((_) async => const Right(true));

        return tvShowWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadTvShowWatchlistStatus(tId)),
      expect: () => [const TvShowWatchlistStatusHasData(true)],
      verify: (_) => verify(mockGetTvShowWatchListStatus.execute(tId)),
    );

    blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
      'Should emit Error when get tv show watchlist status is unsuccessful',
      build: () {
        when(mockGetTvShowWatchListStatus.execute(tId)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')));

        return tvShowWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadTvShowWatchlistStatus(tId)),
      expect: () => [const TvShowWatchlistStatusError('Database Failure')],
      verify: (_) => verify(mockGetTvShowWatchListStatus.execute(tId)),
    );
  });

  group('Insert tv show watchlist test', () {
    blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
      'Should emit Success when insert tv show to database successfully',
      build: () {
        when(mockAddTvShowWatchlist.execute(testTvShowDetail))
            .thenAnswer((_) async => const Right('Added Tv Show to Watchlist'));

        when(mockGetTvShowWatchListStatus.execute(testTvShowDetail.id))
            .thenAnswer((_) async => const Right(true));

        return tvShowWatchlistBloc;
      },
      act: (bloc) => bloc.add(const InsertTvShowWatchlist(testTvShowDetail)),
      expect: () => [
        const InsertOrRemoveTvShowWatchlistSuccess(
          'Added Tv Show to Watchlist',
        ),
        const TvShowWatchlistStatusHasData(true),
      ],
      verify: (_) => verify(mockAddTvShowWatchlist.execute(testTvShowDetail)),
    );

    blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
      'Should emit Failed when insert tv show to database is unsuccessful',
      build: () {
        when(mockAddTvShowWatchlist.execute(testTvShowDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')));

        when(mockGetTvShowWatchListStatus.execute(testTvShowDetail.id))
            .thenAnswer((_) async => const Right(false));

        return tvShowWatchlistBloc;
      },
      act: (bloc) => bloc.add(const InsertTvShowWatchlist(testTvShowDetail)),
      expect: () => [
        const InsertOrRemoveTvShowWatchlistFailed('Database Failure'),
        const TvShowWatchlistStatusHasData(false),
      ],
      verify: (_) => verify(mockAddTvShowWatchlist.execute(testTvShowDetail)),
    );
  });

  group('Remove tv show watchlist test', () {
    blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
      'Should emit Success when remove tv show from database successfully',
      build: () {
        when(mockDeleteTvShowWatchlist.execute(testTvShowDetail)).thenAnswer(
            (_) async => const Right('Remove Tv Show from Watchlist'));

        when(mockGetTvShowWatchListStatus.execute(testTvShowDetail.id))
            .thenAnswer((_) async => const Right(false));

        return tvShowWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveTvShowWatchList(testTvShowDetail)),
      expect: () => [
        const InsertOrRemoveTvShowWatchlistSuccess(
          'Remove Tv Show from Watchlist',
        ),
        const TvShowWatchlistStatusHasData(false),
      ],
      verify: (_) =>
          verify(mockDeleteTvShowWatchlist.execute(testTvShowDetail)),
    );

    blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
      'Should emit Failed when remove tv show from database is unsuccessful',
      build: () {
        when(mockDeleteTvShowWatchlist.execute(testTvShowDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')));

        when(mockGetTvShowWatchListStatus.execute(testTvShowDetail.id))
            .thenAnswer((_) async => const Right(false));

        return tvShowWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveTvShowWatchList(testTvShowDetail)),
      expect: () => [
        const InsertOrRemoveTvShowWatchlistFailed('Database Failure'),
        const TvShowWatchlistStatusHasData(false),
      ],
      verify: (_) =>
          verify(mockDeleteTvShowWatchlist.execute(testTvShowDetail)),
    );
  });
}
