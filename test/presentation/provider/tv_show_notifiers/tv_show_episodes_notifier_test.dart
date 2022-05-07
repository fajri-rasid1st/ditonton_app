import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_episodes.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_episodes_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_episodes_notifier_test.mocks.dart';

@GenerateMocks([GetTvShowEpisodes])
void main() {
  late TvShowEpisodesNotifier provider;
  late MockGetTvShowEpisodes mockGetTvShowEpisodes;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockGetTvShowEpisodes = MockGetTvShowEpisodes();

    provider = TvShowEpisodesNotifier(
      getTvShowEpisodeDetail: mockGetTvShowEpisodes,
    )..addListener(() => listenerCallCount++);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  const tEpisode = Episode(
    airDate: 'airDate',
    episodeNumber: 1,
    name: 'name',
    overview: 'overview',
    stillPath: 'stillPath',
  );

  final tEpisodeList = <Episode>[tEpisode];

  test('Should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvShowEpisodes.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(tEpisodeList));

    // act
    provider.fetchTvShowEpisode(tId, tSeasonNumber);

    // assert
    expect(provider.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test(
    'Should change episodes data when data is gotten successfully',
    () async {
      // arrange
      when(mockGetTvShowEpisodes.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodeList));

      // act
      await provider.fetchTvShowEpisode(tId, tSeasonNumber);

      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.episodes, tEpisodeList);
      expect(listenerCallCount, 2);
    },
  );

  test('Should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvShowEpisodes.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

    // act
    await provider.fetchTvShowEpisode(tId, tSeasonNumber);

    // assert
    expect(provider.state, RequestState.error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
