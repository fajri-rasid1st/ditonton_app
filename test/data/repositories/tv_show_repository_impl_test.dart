import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_model.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRemoteDataSource mockRemoteDataSource;
  late MockTvShowLocalDataSource mockLocalDataSource;
  late TvShowRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockTvShowRemoteDataSource();
    mockLocalDataSource = MockTvShowLocalDataSource();
    repository = TvShowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tTvShowModel = TvShowModel(
    id: 1399,
    name: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
  );

  const tEpisodeModel = EpisodeModel(
    airDate: "2013-09-12",
    episodeNumber: 1,
    name: "Episode 1",
    overview:
        "Birmingham, 1919. Thomas Shelby controls the Peaky Blinders, one of the city's most feared criminal organisations, but his ambitions go beyond running the streets. When a crate of guns goes missing, Thomas recognises an opportunity to move up in the world.",
    stillPath: "/tplu6cXP312IN5rrT5K81zFZpMd.jpg",
  );

  const tTvShow = TvShow(
    id: 1399,
    name: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
  );

  const tEpisode = Episode(
    airDate: "2013-09-12",
    episodeNumber: 1,
    name: "Episode 1",
    overview:
        "Birmingham, 1919. Thomas Shelby controls the Peaky Blinders, one of the city's most feared criminal organisations, but his ambitions go beyond running the streets. When a crate of guns goes missing, Thomas recognises an opportunity to move up in the world.",
    stillPath: "/tplu6cXP312IN5rrT5K81zFZpMd.jpg",
  );

  final tTvShowModelList = <TvShowModel>[tTvShowModel];
  final tEpisodeModelList = <EpisodeModel>[tEpisodeModel];
  final tTvShowList = <TvShow>[tTvShow];
  final tEpisodeList = <Episode>[tEpisode];

  group('On the air tv shows', () {
    test(
      'Should return tv show list when call to data source is success',
      () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvShows())
            .thenAnswer((_) async => tTvShowModelList);

        // act
        final result = await repository.getOnTheAirTvShows();

        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);

        expect(resultList, tTvShowList);
      },
    );

    test(
      'Should return server failure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvShows())
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.getOnTheAirTvShows();

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
        when(mockRemoteDataSource.getOnTheAirTvShows()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getOnTheAirTvShows();

        // assert
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Popular tv shows', () {
    test(
      'Should return tv show list when call to data source is success',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvShows())
            .thenAnswer((_) async => tTvShowModelList);

        // act
        final result = await repository.getPopularTvShows();

        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);

        expect(resultList, tTvShowList);
      },
    );

    test(
      'Should return server failure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvShows())
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.getPopularTvShows();

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
        when(mockRemoteDataSource.getPopularTvShows()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getPopularTvShows();

        // assert
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Top rated tv shows', () {
    test(
      'Should return tv show list when call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvShows())
            .thenAnswer((_) async => tTvShowModelList);

        // act
        final result = await repository.getTopRatedTvShows();

        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);

        expect(resultList, tTvShowList);
      },
    );

    test(
      'Should return ServerFailure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvShows())
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.getTopRatedTvShows();

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
        when(mockRemoteDataSource.getTopRatedTvShows()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTopRatedTvShows();

        // assert
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Get tv show detail', () {
    const tId = 1;

    const tTvShowResponse = TvShowDetailModel(
      firstAirDate: '2011-04-17',
      genres: [GenreModel(name: 'Action')],
      id: 1,
      lastAirDate: '2019-05-19',
      name: 'name',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      seasons: [
        SeasonModel(
          airDate: '2011-04-17',
          episodeCount: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1,
        )
      ],
      voteAverage: 1,
      voteCount: 1,
    );

    test(
      'Should return Tv Show data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvShowDetail(tId))
            .thenAnswer((_) async => tTvShowResponse);

        // act
        final result = await repository.getTvShowDetail(tId);

        // assert
        verify(mockRemoteDataSource.getTvShowDetail(tId));

        expect(result, equals(const Right(testTvShowDetail)));
      },
    );

    test(
      'Should return Server Failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvShowDetail(tId))
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.getTvShowDetail(tId);

        // assert
        verify(mockRemoteDataSource.getTvShowDetail(tId));

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
        when(mockRemoteDataSource.getTvShowDetail(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTvShowDetail(tId);

        // assert
        verify(mockRemoteDataSource.getTvShowDetail(tId));

        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });

  group('Get tv show recommendations', () {
    const tId = 1;

    final tTvShowList = <TvShowModel>[];

    test(
      'Should return data (tv show list) when the call is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvShowRecommendations(tId))
            .thenAnswer((_) async => tTvShowList);

        // act
        final result = await repository.getTvShowRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getTvShowRecommendations(tId));

        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);

        expect(resultList, equals(tTvShowList));
      },
    );

    test(
      'Should return server failure when call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvShowRecommendations(tId))
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.getTvShowRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getTvShowRecommendations(tId));

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
        when(mockRemoteDataSource.getTvShowRecommendations(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTvShowRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getTvShowRecommendations(tId));
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });

  group('Seach tv shows', () {
    const tQuery = 'Game';

    test(
      'Should return tv show list when call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.searchTvShows(tQuery))
            .thenAnswer((_) async => tTvShowModelList);

        // act
        final result = await repository.searchTvShows(tQuery);

        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);

        expect(resultList, tTvShowList);
      },
    );

    test(
      'Should return ServerFailure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.searchTvShows(tQuery))
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.searchTvShows(tQuery);

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
        when(mockRemoteDataSource.searchTvShows(tQuery)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.searchTvShows(tQuery);

        // assert
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Get tv show episodes', () {
    const tId = 1;
    const tSeasonNumber = 1;

    test(
      'Should return episode list when call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvShowEpisodes(tId, tSeasonNumber))
            .thenAnswer((_) async => tEpisodeModelList);

        // act
        final result = await repository.getTvShowEpisodes(tId, tSeasonNumber);

        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);

        expect(resultList, tEpisodeList);
      },
    );

    test(
      'Should return ServerFailure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvShowEpisodes(tId, tSeasonNumber))
            .thenThrow(ServerException('Internal Server Error'));

        // act
        final result = await repository.getTvShowEpisodes(tId, tSeasonNumber);

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
        when(mockRemoteDataSource.getTvShowEpisodes(
          tId,
          tSeasonNumber,
        )).thenThrow(const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTvShowEpisodes(tId, tSeasonNumber);

        // assert
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Add tv show watchlist', () {
    test('Should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      // act
      final result = await repository.addTvShowWatchlist(testTvShowDetail);

      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('Should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertTvShowWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      // act
      final result = await repository.addTvShowWatchlist(testTvShowDetail);

      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove tv show watchlist', () {
    test('Should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');

      // act
      final result = await repository.deleteTvShowWatchlist(testTvShowDetail);

      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('Should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeTvShowWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      // act
      final result = await repository.deleteTvShowWatchlist(testTvShowDetail);

      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get tv show watchlist status', () {
    test('Should return watchlist status whether data is found', () async {
      // arrange
      const tId = 1;

      when(mockLocalDataSource.getTvShowById(tId))
          .thenAnswer((_) async => null);

      // act
      final result = await repository.isTvShowAddedToWatchlist(tId);

      // assert
      expect(result, const Right(false));
    });

    test('Should return DatabaseFailure when status checker failed', () async {
      // arrange
      const tId = 1;

      when(mockLocalDataSource.getTvShowById(tId))
          .thenThrow(DatabaseException('Failed to get watchlist status'));

      // act
      final result = await repository.isTvShowAddedToWatchlist(tId);

      // assert
      expect(
        result,
        const Left(DatabaseFailure('Failed to get watchlist status')),
      );
    });
  });

  group('Get watchlist tv shows', () {
    test('Should return list of tv shows', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowTable]);

      // act
      final result = await repository.getWatchlistTvShows();

      // assert
      final resultList = result.getOrElse(() => []);

      expect(resultList, <TvShow>[testWatchlistTvShow]);
    });

    test(
      'Should return DatabaseFailure when watchlist tv shows getter failed',
      () async {
        // arrange
        when(mockLocalDataSource.getWatchlistTvShows())
            .thenThrow(DatabaseException('Failed to get watchlist tv shows'));

        // act
        final result = await repository.getWatchlistTvShows();

        // assert
        expect(
          result,
          const Left(DatabaseFailure('Failed to get watchlist tv shows')),
        );
      },
    );
  });
}
