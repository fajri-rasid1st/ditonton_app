import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'on_the_air_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvShows])
void main() {
  late OnTheAirTvShowsBloc onTheAirTvShowsBloc;
  late MockGetOnTheAirTvShows mockGetOnTheAirTvShows;

  setUp(() {
    mockGetOnTheAirTvShows = MockGetOnTheAirTvShows();
    onTheAirTvShowsBloc = OnTheAirTvShowsBloc(
      getOnTheAirTvShows: mockGetOnTheAirTvShows,
    );
  });

  test('Initial state should be empty', () {
    expect(onTheAirTvShowsBloc.state, OnTheAirTvShowsEmpty());
  });

  blocTest<OnTheAirTvShowsBloc, OnTheAirTvShowsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirTvShows.execute())
          .thenAnswer((_) async => const Right(testTvShowList));

      return onTheAirTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvShows()),
    expect: () => [
      OnTheAirTvShowsLoading(),
      const OnTheAirTvShowsHasData(testTvShowList),
    ],
    verify: (_) => verify(mockGetOnTheAirTvShows.execute()),
  );

  blocTest<OnTheAirTvShowsBloc, OnTheAirTvShowsState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetOnTheAirTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return onTheAirTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvShows()),
    expect: () => [
      OnTheAirTvShowsLoading(),
      const OnTheAirTvShowsError('Server Failure'),
    ],
    verify: (_) => verify(mockGetOnTheAirTvShows.execute()),
  );
}
