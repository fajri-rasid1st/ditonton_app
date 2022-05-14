import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie_usecases/add_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/delete_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieWatchListStatus,
  AddMovieWatchlist,
  DeleteMovieWatchlist,
])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetMovieWatchListStatus mockGetMovieWatchListStatus;
  late MockAddMovieWatchlist mockAddMovieWatchlist;
  late MockDeleteMovieWatchlist mockDeleteMovieWatchlist;

  const tId = 1;

  setUp(() {
    mockGetMovieWatchListStatus = MockGetMovieWatchListStatus();
    mockAddMovieWatchlist = MockAddMovieWatchlist();
    mockDeleteMovieWatchlist = MockDeleteMovieWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
      getMovieWatchListStatus: mockGetMovieWatchListStatus,
      addMovieWatchlist: mockAddMovieWatchlist,
      deleteMovieWatchlist: mockDeleteMovieWatchlist,
    );
  });

  test('Initial state should be empty', () {
    expect(movieWatchlistBloc.state, MovieWatchlistStatusEmpty());
  });

  group('Movie watchlist status test', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit HasData when movie watchlist status is gotten successfully',
      build: () {
        when(mockGetMovieWatchListStatus.execute(tId))
            .thenAnswer((_) async => const Right(true));

        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadMovieWatchlistStatus(tId)),
      expect: () => [const MovieWatchlistStatusHasData(true)],
      verify: (_) => verify(mockGetMovieWatchListStatus.execute(tId)),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit Error when get movie watchlist status is unsuccessful',
      build: () {
        when(mockGetMovieWatchListStatus.execute(tId)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')));

        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadMovieWatchlistStatus(tId)),
      expect: () => [const MovieWatchlistStatusError('Database Failure')],
      verify: (_) => verify(mockGetMovieWatchListStatus.execute(tId)),
    );
  });

  group('Insert movie watchlist test', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit Success when insert movie to database successfully',
      build: () {
        when(mockAddMovieWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added Movie to Watchlist'));

        when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => const Right(true));

        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const InsertMovieWatchlist(testMovieDetail)),
      expect: () => [
        const InsertOrRemoveMovieWatchlistSuccess('Added Movie to Watchlist'),
        const MovieWatchlistStatusHasData(true),
      ],
      verify: (_) => verify(mockAddMovieWatchlist.execute(testMovieDetail)),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit Failed when insert movie to database is unsuccessful',
      build: () {
        when(mockAddMovieWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')));

        when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => const Right(false));

        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const InsertMovieWatchlist(testMovieDetail)),
      expect: () => [
        const InsertOrRemoveMovieWatchlistFailed('Database Failure'),
        const MovieWatchlistStatusHasData(false),
      ],
      verify: (_) => verify(mockAddMovieWatchlist.execute(testMovieDetail)),
    );
  });

  group('Remove movie watchlist test', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit Success when remove movie from database successfully',
      build: () {
        when(mockDeleteMovieWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Right('Remove Movie from Watchlist'));

        when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => const Right(false));

        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveMovieWatchList(testMovieDetail)),
      expect: () => [
        const InsertOrRemoveMovieWatchlistSuccess(
          'Remove Movie from Watchlist',
        ),
        const MovieWatchlistStatusHasData(false),
      ],
      verify: (_) => verify(mockDeleteMovieWatchlist.execute(testMovieDetail)),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit Failed when remove movie from database is unsuccessful',
      build: () {
        when(mockDeleteMovieWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')));

        when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => const Right(false));

        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveMovieWatchList(testMovieDetail)),
      expect: () => [
        const InsertOrRemoveMovieWatchlistFailed('Database Failure'),
        const MovieWatchlistStatusHasData(false),
      ],
      verify: (_) => verify(mockDeleteMovieWatchlist.execute(testMovieDetail)),
    );
  });
}
