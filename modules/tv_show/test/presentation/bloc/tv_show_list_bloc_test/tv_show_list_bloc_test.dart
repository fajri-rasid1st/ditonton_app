import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../on_the_air_tv_shows_bloc/on_the_air_tv_shows_bloc_test.mocks.dart';
import '../popular_tv_shows_bloc/popular_tv_shows_bloc_test.mocks.dart';
import '../top_rated_tv_shows_bloc/top_rated_tv_shows_bloc_test.mocks.dart';

void main() {
  late TvShowlistBloc tvShowlistBloc;
  late MockGetOnTheAirTvShows mockGetOnTheAirTvShows;
  late MockGetPopularTvShows mockGetPopularTvShows;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;

  setUp(() {
    mockGetOnTheAirTvShows = MockGetOnTheAirTvShows();
    mockGetPopularTvShows = MockGetPopularTvShows();
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    tvShowlistBloc = TvShowlistBloc(
      getOnTheAirTvShows: mockGetOnTheAirTvShows,
      getPopularTvShows: mockGetPopularTvShows,
      getTopRatedTvShows: mockGetTopRatedTvShows,
    );
  });

  test('Initial state should be empty', () {
    expect(tvShowlistBloc.state, TvShowlistEmpty());
  });

  blocTest<TvShowlistBloc, TvShowlistState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirTvShows.execute())
          .thenAnswer((_) async => const Right(testTvShowList));

      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => const Right(testTvShowList));

      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => const Right(testTvShowList));

      return tvShowlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowlist()),
    expect: () => [
      TvShowlistLoading(),
      const TvShowlistHasData(testTvShowList, testTvShowList, testTvShowList),
    ],
    verify: (_) {
      verify(mockGetOnTheAirTvShows.execute());
      verify(mockGetPopularTvShows.execute());
      verify(mockGetTopRatedTvShows.execute());
    },
  );

  blocTest<TvShowlistBloc, TvShowlistState>(
    'Should emit [Loading, Error] when get top rated tv shows data is unsuccessful',
    build: () {
      when(mockGetOnTheAirTvShows.execute())
          .thenAnswer((_) async => const Right(testTvShowList));

      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => const Right(testTvShowList));

      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return tvShowlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowlist()),
    expect: () => [
      TvShowlistLoading(),
      const TvShowlistError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetOnTheAirTvShows.execute());
      verify(mockGetPopularTvShows.execute());
      verify(mockGetTopRatedTvShows.execute());
    },
  );

  blocTest<TvShowlistBloc, TvShowlistState>(
    'Should emit [Loading, Error] when get popular tv shows data is unsuccessful',
    build: () {
      when(mockGetOnTheAirTvShows.execute())
          .thenAnswer((_) async => const Right(testTvShowList));

      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return tvShowlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowlist()),
    expect: () => [
      TvShowlistLoading(),
      const TvShowlistError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetOnTheAirTvShows.execute());
      verify(mockGetPopularTvShows.execute());
      verify(mockGetTopRatedTvShows.execute());
    },
  );

  blocTest<TvShowlistBloc, TvShowlistState>(
    'Should emit [Loading, Error] when get on the air tv shows data is unsuccessful',
    build: () {
      when(mockGetOnTheAirTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return tvShowlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvShowlist()),
    expect: () => [
      TvShowlistLoading(),
      const TvShowlistError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetOnTheAirTvShows.execute());
      verify(mockGetPopularTvShows.execute());
      verify(mockGetTopRatedTvShows.execute());
    },
  );
}
