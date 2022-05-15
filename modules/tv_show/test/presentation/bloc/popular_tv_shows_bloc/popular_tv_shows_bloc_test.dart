import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late PopularTvShowsBloc popularTvShowsBloc;
  late MockGetPopularTvShows mockGetPopularTvShows;

  setUp(() {
    mockGetPopularTvShows = MockGetPopularTvShows();
    popularTvShowsBloc = PopularTvShowsBloc(
      getPopularTvShows: mockGetPopularTvShows,
    );
  });

  test('Initial state should be empty', () {
    expect(popularTvShowsBloc.state, PopularTvShowsEmpty());
  });

  blocTest<PopularTvShowsBloc, PopularTvShowsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => const Right(testTvShowList));

      return popularTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvShows()),
    expect: () => [
      PopularTvShowsLoading(),
      const PopularTvShowsHasData(testTvShowList),
    ],
    verify: (_) => verify(mockGetPopularTvShows.execute()),
  );

  blocTest<PopularTvShowsBloc, PopularTvShowsState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return popularTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvShows()),
    expect: () => [
      PopularTvShowsLoading(),
      const PopularTvShowsError('Server Failure'),
    ],
    verify: (_) => verify(mockGetPopularTvShows.execute()),
  );
}
