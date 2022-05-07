import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/top_rated_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

void main() {
  late TopRatedMoviesNotifier provider;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockGetTopRatedMovies = MockGetTopRatedMovies();

    provider = TopRatedMoviesNotifier(getTopRatedMovies: mockGetTopRatedMovies)
      ..addListener(() => listenerCallCount++);
  });

  const tMovie = Movie(
    id: 1,
    title: 'title',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  final tMovieList = <Movie>[tMovie];

  test('Should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));

    // act
    provider.fetchTopRatedMovies();

    // assert
    expect(provider.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('Should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));

    // act
    await provider.fetchTopRatedMovies();

    // assert
    expect(provider.state, RequestState.loaded);
    expect(provider.movies, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('Should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedMovies.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

    // act
    await provider.fetchTopRatedMovies();

    // assert
    expect(provider.state, RequestState.error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}