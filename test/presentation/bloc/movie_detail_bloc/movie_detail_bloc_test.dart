import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  const tId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  test('Initial state should be empty', () {
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Right(testMovieDetail));

      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => const Right(testMovieList));

      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailHasData(testMovieDetail, testMovieList),
    ],
    verify: (_) {
      verify(mockGetMovieDetail.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when get movie detail is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => const Right(testMovieList));

      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetMovieDetail.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when get movie recommendations is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Right(testMovieDetail));

      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetMovieDetail.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when get movie detail and recommendations is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetMovieDetail.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );
}
