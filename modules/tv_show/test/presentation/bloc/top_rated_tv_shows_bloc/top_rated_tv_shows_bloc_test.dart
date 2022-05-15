import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvShows])
void main() {
  late TopRatedTvShowsBloc topRatedTvShowsBloc;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;

  setUp(() {
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    topRatedTvShowsBloc = TopRatedTvShowsBloc(
      getTopRatedTvShows: mockGetTopRatedTvShows,
    );
  });

  test('Initial state should be empty', () {
    expect(topRatedTvShowsBloc.state, TopRatedTvShowsEmpty());
  });

  blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => const Right(testTvShowList));

      return topRatedTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvShows()),
    expect: () => [
      TopRatedTvShowsLoading(),
      const TopRatedTvShowsHasData(testTvShowList),
    ],
    verify: (_) => verify(mockGetTopRatedTvShows.execute()),
  );

  blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return topRatedTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvShows()),
    expect: () => [
      TopRatedTvShowsLoading(),
      const TopRatedTvShowsError('Server Failure'),
    ],
    verify: (_) => verify(mockGetTopRatedTvShows.execute()),
  );
}
