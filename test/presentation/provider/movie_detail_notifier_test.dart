import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/add_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/delete_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetMovieWatchListStatus,
  AddMovieWatchlist,
  DeleteMovieWatchlist,
])
void main() {
  late MovieDetailNotifier provider;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetMovieWatchListStatus mockGetMovieWatchListStatus;
  late MockAddMovieWatchlist mockAddMovieWatchlist;
  late MockDeleteMovieWatchlist mockDeleteMovieWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetMovieWatchListStatus = MockGetMovieWatchListStatus();
    mockAddMovieWatchlist = MockAddMovieWatchlist();
    mockDeleteMovieWatchlist = MockDeleteMovieWatchlist();

    provider = MovieDetailNotifier(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getMovieWatchListStatus: mockGetMovieWatchListStatus,
      addMovieWatchlist: mockAddMovieWatchlist,
      deleteMovieWatchlist: mockDeleteMovieWatchlist,
    )..addListener(() => listenerCallCount++);
  });

  const tId = 1;

  const tMovie = Movie(
    id: 1,
    title: 'title',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));

    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get movie detail', () {
    test('Should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchMovieDetail(tId);

      // assert
      verify(mockGetMovieDetail.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    });

    test('Should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();

      // act
      provider.fetchMovieDetail(tId);

      // assert
      expect(provider.movieState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('Should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchMovieDetail(tId);

      // assert
      expect(provider.movieState, RequestState.loaded);
      expect(provider.movie, testMovieDetail);
      expect(listenerCallCount, 3);
    });

    test(
      'Should change recommendation movies when data is gotten successfully',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchMovieDetail(tId);

        // assert
        expect(provider.movieState, RequestState.loaded);
        expect(provider.movieRecommendations, tMovies);
      },
    );
  });

  group('Get movie recommendations', () {
    test('Should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchMovieDetail(tId);

      // assert
      verify(mockGetMovieRecommendations.execute(tId));

      expect(provider.movieRecommendations, tMovies);
    });

    test(
      'Should update recommendation state when data is gotten successfully',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchMovieDetail(tId);

        // assert
        expect(provider.recommendationState, RequestState.loaded);
        expect(provider.movieRecommendations, tMovies);
      },
    );

    test('Should update error message when request in successful', () async {
      // arrange
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Right(testMovieDetail));

      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));

      // act
      await provider.fetchMovieDetail(tId);

      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Get watchlist', () {
    test('Should get the watchlist status', () async {
      // arrange
      when(mockGetMovieWatchListStatus.execute(1))
          .thenAnswer((_) async => const Right(true));

      // act
      await provider.loadMovieWatchlistStatus(1);

      // assert
      verify(mockGetMovieWatchListStatus.execute(1));

      expect(provider.isAddedToWatchlist, true);
    });

    test('Should execute add watchlist when function called', () async {
      // arrange
      when(mockAddMovieWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Success'));

      when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => const Right(true));

      // act
      await provider.addMovieToWatchlist(testMovieDetail);

      // assert
      verify(mockAddMovieWatchlist.execute(testMovieDetail));
    });

    test('Should execute delete watchlist when function called', () async {
      // arrange
      when(mockDeleteMovieWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Removed'));

      when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => const Right(false));

      // act
      await provider.removeMovieFromWatchlist(testMovieDetail);

      // assert
      verify(mockDeleteMovieWatchlist.execute(testMovieDetail));
    });

    test('Should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockAddMovieWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));

      when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => const Right(true));

      // act
      await provider.addMovieToWatchlist(testMovieDetail);

      // assert
      verify(mockGetMovieWatchListStatus.execute(testMovieDetail.id));

      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('Should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockAddMovieWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));

      when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => const Right(false));

      // act
      await provider.addMovieToWatchlist(testMovieDetail);

      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('Should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovies));

      // act
      await provider.fetchMovieDetail(tId);

      // assert
      expect(provider.movieState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
