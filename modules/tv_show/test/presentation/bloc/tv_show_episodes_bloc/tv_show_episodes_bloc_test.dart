import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_episodes_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowEpisodes])
void main() {
  late TvShowEpisodesBloc tvShowEpisodesBloc;
  late MockGetTvShowEpisodes mockGetTvShowEpisodes;

  const tId = 1;
  const tSeasonNumber = 1;

  setUp(() {
    mockGetTvShowEpisodes = MockGetTvShowEpisodes();
    tvShowEpisodesBloc = TvShowEpisodesBloc(
      getTvShowEpisodes: mockGetTvShowEpisodes,
    );
  });

  test('Initial state should be empty', () {
    expect(tvShowEpisodesBloc.state, TvShowEpisodesEmpty());
  });

  blocTest<TvShowEpisodesBloc, TvShowEpisodesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvShowEpisodes.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => const Right(testEpisodeList));

      return tvShowEpisodesBloc;
    },
    act: (bloc) => bloc.add(const FetchTvShowEpisodes(tId, tSeasonNumber)),
    expect: () => [
      TvShowEpisodesLoading(),
      const TvShowEpisodesHasData(testEpisodeList),
    ],
    verify: (_) => verify(mockGetTvShowEpisodes.execute(tId, tSeasonNumber)),
  );

  blocTest<TvShowEpisodesBloc, TvShowEpisodesState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTvShowEpisodes.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return tvShowEpisodesBloc;
    },
    act: (bloc) => bloc.add(const FetchTvShowEpisodes(tId, tSeasonNumber)),
    expect: () => [
      TvShowEpisodesLoading(),
      const TvShowEpisodesError('Server Failure'),
    ],
    verify: (_) => verify(mockGetTvShowEpisodes.execute(tId, tSeasonNumber)),
  );
}
