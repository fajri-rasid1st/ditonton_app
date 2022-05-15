import 'dart:io';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  late MovieRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tMovieModel = MovieModel(
    id: 557,
    title: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  );

  const tMovie = Movie(
    id: 557,
    title: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Now playing movies', () {
    test(
      'Should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenAnswer((_) async => tMovieModelList);

        // act
        final result = await repository.getNowPlayingMovies();

        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());

        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);

        expect(resultList, tMovieList);
      },
    );

    test(
      'Should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.getNowPlayingMovies();

        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());

        expect(
          result,
          equals(const Left(ServerFailure('Failed to connect to the server'))),
        );
      },
    );

    test(
      'Should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getNowPlayingMovies();

        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());

        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });

  group('Popular movies', () {
    test(
      'Should return movie list when call to data source is success',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenAnswer((_) async => tMovieModelList);

        // act
        final result = await repository.getPopularMovies();

        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);

        expect(resultList, tMovieList);
      },
    );

    test(
      'Should return server failure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.getPopularMovies();

        // assert
        expect(
          result,
          const Left(ServerFailure('Failed to connect to the server')),
        );
      },
    );

    test(
      'Should return connection failure when device is not connected to the internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getPopularMovies();

        // assert
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Top rated movies', () {
    test(
      'Should return movie list when call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenAnswer((_) async => tMovieModelList);

        // act
        final result = await repository.getTopRatedMovies();

        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);

        expect(resultList, tMovieList);
      },
    );

    test(
      'Should return ServerFailure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.getTopRatedMovies();

        // assert
        expect(
          result,
          const Left(ServerFailure('Failed to connect to the server')),
        );
      },
    );

    test(
      'Should return ConnectionFailure when device is not connected to the internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTopRatedMovies();

        // assert
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Get movie detail', () {
    const tId = 1;

    const tMovieResponse = MovieDetailModel(
      genres: [GenreModel(name: 'Action')],
      id: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      runtime: 120,
      title: 'title',
      voteAverage: 1,
      voteCount: 1,
    );

    test(
      'Should return Movie data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieDetail(tId))
            .thenAnswer((_) async => tMovieResponse);

        // act
        final result = await repository.getMovieDetail(tId);

        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));

        expect(result, equals(const Right(testMovieDetail)));
      },
    );

    test(
      'Should return Server Failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieDetail(tId))
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.getMovieDetail(tId);

        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));

        expect(
          result,
          equals(const Left(ServerFailure('Failed to connect to the server'))),
        );
      },
    );

    test(
      'Should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieDetail(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getMovieDetail(tId);

        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));

        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });

  group('Get movie recommendations', () {
    const tId = 1;

    final tMovieList = <MovieModel>[];

    test(
      'Should return data (movie list) when the call is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieRecommendations(tId))
            .thenAnswer((_) async => tMovieList);

        // act
        final result = await repository.getMovieRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getMovieRecommendations(tId));

        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);

        expect(resultList, equals(tMovieList));
      },
    );

    test(
      'Should return server failure when call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieRecommendations(tId))
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.getMovieRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getMovieRecommendations(tId));

        expect(
          result,
          equals(const Left(ServerFailure('Failed to connect to the server'))),
        );
      },
    );

    test(
      'Should return connection failure when the device is not connected to the internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieRecommendations(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getMovieRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });

  group('Seach movies', () {
    const tQuery = 'Spiderman';

    test(
      'Should return movie list when call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.searchMovies(tQuery))
            .thenAnswer((_) async => tMovieModelList);

        // act
        final result = await repository.searchMovies(tQuery);

        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);

        expect(resultList, tMovieList);
      },
    );

    test(
      'Should return ServerFailure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.searchMovies(tQuery))
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.searchMovies(tQuery);

        // assert
        expect(
          result,
          const Left(ServerFailure('Failed to connect to the server')),
        );
      },
    );

    test(
      'Should return ConnectionFailure when device is not connected to the internet',
      () async {
        // arrange
        when(mockRemoteDataSource.searchMovies(tQuery)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.searchMovies(tQuery);

        // assert
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Add movie watchlist', () {
    test('Should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      // act
      final result = await repository.addMovieWatchlist(testMovieDetail);

      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('Should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertMovieWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      // act
      final result = await repository.addMovieWatchlist(testMovieDetail);

      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove movie watchlist', () {
    test('Should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');

      // act
      final result = await repository.deleteMovieWatchlist(testMovieDetail);

      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('Should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeMovieWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      // act
      final result = await repository.deleteMovieWatchlist(testMovieDetail);

      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get movie watchlist status', () {
    test('Should return watchlist status whether data is found', () async {
      // arrange
      const tId = 1;

      when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);

      // act
      final result = await repository.isMovieAddedToWatchlist(tId);

      // assert
      expect(result, const Right(false));
    });

    test('Should return DatabaseFailure when status checker failed', () async {
      // arrange
      const tId = 1;

      when(mockLocalDataSource.getMovieById(tId))
          .thenThrow(DatabaseException('Failed to get watchlist status'));

      // act
      final result = await repository.isMovieAddedToWatchlist(tId);

      // assert
      expect(
        result,
        const Left(DatabaseFailure('Failed to get watchlist status')),
      );
    });
  });

  group('Get watchlist movies', () {
    test('Should return list of Movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTable]);

      // act
      final result = await repository.getWatchlistMovies();

      // assert
      final resultList = result.getOrElse(() => []);

      expect(resultList, <Movie>[testWatchlistMovie]);
    });

    test(
      'Should return DatabaseFailure when watchlist movies getter failed',
      () async {
        // arrange
        when(mockLocalDataSource.getWatchlistMovies())
            .thenThrow(DatabaseException('Failed to get watchlist movies'));

        // act
        final result = await repository.getWatchlistMovies();

        // assert
        expect(
          result,
          const Left(DatabaseFailure('Failed to get watchlist movies')),
        );
      },
    );
  });
}
