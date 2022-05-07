import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/on_the_air_tv_shows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_list_notifier_test.mocks.dart';

void main() {
  late OnTheAirTvShowsNotifier provider;
  late MockGetOnTheAirTvShows mockGetOnTheAirTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockGetOnTheAirTvShows = MockGetOnTheAirTvShows();

    provider = OnTheAirTvShowsNotifier(
      getOnTheAirTvShows: mockGetOnTheAirTvShows,
    )..addListener(() => listenerCallCount++);
  });

  const tTvShow = TvShow(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  final tTvShowList = <TvShow>[tTvShow];

  test('Should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetOnTheAirTvShows.execute())
        .thenAnswer((_) async => Right(tTvShowList));

    // act
    provider.fetchOnTheAirTvShows();

    // assert
    expect(provider.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test(
    'Should change tv shows data when data is gotten successfully',
    () async {
      // arrange
      when(mockGetOnTheAirTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));

      // act
      await provider.fetchOnTheAirTvShows();

      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.tvShows, tTvShowList);
      expect(listenerCallCount, 2);
    },
  );

  test('Should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetOnTheAirTvShows.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

    // act
    await provider.fetchOnTheAirTvShows();

    // assert
    expect(provider.state, RequestState.error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
