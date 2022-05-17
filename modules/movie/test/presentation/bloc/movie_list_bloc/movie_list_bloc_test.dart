import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../now_playing_movies_bloc/now_playing_movies_bloc_test.mocks.dart';
import '../popular_movies_bloc/popular_movies_bloc_test.mocks.dart';
import '../top_rated_movies_bloc/top_rated_movies_bloc_test.mocks.dart';

void main() {
  late MovielistBloc movielistBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movielistBloc = MovielistBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  test('Initial state should be empty', () {
    expect(movielistBloc.state, MovielistEmpty());
  });

  blocTest<MovielistBloc, MovielistState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Right(testMovieList));

      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right(testMovieList));

      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Right(testMovieList));

      return movielistBloc;
    },
    act: (bloc) => bloc.add(FetchMovielist()),
    expect: () => [
      MovielistLoading(),
      const MovielistHasData(testMovieList, testMovieList, testMovieList),
    ],
    verify: (_) {
      verify(mockGetNowPlayingMovies.execute());
      verify(mockGetPopularMovies.execute());
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<MovielistBloc, MovielistState>(
    'Should emit [Loading, Error] when get top rated movies data is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Right(testMovieList));

      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right(testMovieList));

      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return movielistBloc;
    },
    act: (bloc) => bloc.add(FetchMovielist()),
    expect: () => [
      MovielistLoading(),
      const MovielistError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetNowPlayingMovies.execute());
      verify(mockGetPopularMovies.execute());
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<MovielistBloc, MovielistState>(
    'Should emit [Loading, Error] when get popular movies data is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Right(testMovieList));

      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return movielistBloc;
    },
    act: (bloc) => bloc.add(FetchMovielist()),
    expect: () => [
      MovielistLoading(),
      const MovielistError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetNowPlayingMovies.execute());
      verify(mockGetPopularMovies.execute());
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<MovielistBloc, MovielistState>(
    'Should emit [Loading, Error] when get now playing movies data is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return movielistBloc;
    },
    act: (bloc) => bloc.add(FetchMovielist()),
    expect: () => [
      MovielistLoading(),
      const MovielistError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetNowPlayingMovies.execute());
      verify(mockGetPopularMovies.execute());
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
