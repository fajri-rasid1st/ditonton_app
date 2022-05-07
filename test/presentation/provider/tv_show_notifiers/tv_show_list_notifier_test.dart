import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_on_the_air_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_top_rated_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetOnTheAirTvShows,
  GetPopularTvShows,
  GetTopRatedTvShows,
])
void main() {
  late TvShowListNotifier provider;
  late MockGetOnTheAirTvShows mockGetOnTheAirTvShows;
  late MockGetPopularTvShows mockGetPopularTvShows;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockGetOnTheAirTvShows = MockGetOnTheAirTvShows();
    mockGetPopularTvShows = MockGetPopularTvShows();
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();

    provider = TvShowListNotifier(
      getOnTheAirTvShows: mockGetOnTheAirTvShows,
      getPopularTvShows: mockGetPopularTvShows,
      getTopRatedTvShows: mockGetTopRatedTvShows,
    )..addListener(() => listenerCallCount++);
  });

  const tTvShow = TvShow(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  final tTvShowList = <TvShow>[tTvShow];

  group('On the air tv shows', () {
    test('InitialState should be Empty', () {
      expect(provider.onTheAirTvShowsState, equals(RequestState.empty));
    });

    test('Should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));

      // act
      provider.fetchOnTheAirTvShows();

      // assert
      verify(mockGetOnTheAirTvShows.execute());
    });

    test('Should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));

      // act
      provider.fetchOnTheAirTvShows();

      // assert
      expect(provider.onTheAirTvShowsState, RequestState.loading);
    });

    test('Should change tv shows when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));

      // act
      await provider.fetchOnTheAirTvShows();

      // assert
      expect(provider.onTheAirTvShowsState, RequestState.loaded);
      expect(provider.onTheAirTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('Should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchOnTheAirTvShows();

      // assert
      expect(provider.onTheAirTvShowsState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Popular tv shows', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));

      // act
      provider.fetchPopularTvShows();

      // assert
      expect(provider.popularTvShowsState, RequestState.loading);
    });

    test(
      'Should change tv shows data when data is gotten successfully',
      () async {
        // arrange
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));

        // act
        await provider.fetchPopularTvShows();

        // assert
        expect(provider.popularTvShowsState, RequestState.loaded);
        expect(provider.popularTvShows, tTvShowList);
        expect(listenerCallCount, 2);
      },
    );

    test('Should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchPopularTvShows();

      // assert
      expect(provider.popularTvShowsState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Top rated tv shows', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));

      // act
      provider.fetchTopRatedTvShows();

      // assert
      expect(provider.topRatedTvShowsState, RequestState.loading);
    });

    test(
      'Should change tv shows data when data is gotten successfully',
      () async {
        // arrange
        when(mockGetTopRatedTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));

        // act
        await provider.fetchTopRatedTvShows();

        // assert
        expect(provider.topRatedTvShowsState, RequestState.loaded);
        expect(provider.topRatedTvShows, tTvShowList);
        expect(listenerCallCount, 2);
      },
    );

    test('Should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchTopRatedTvShows();

      // assert
      expect(provider.topRatedTvShowsState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
