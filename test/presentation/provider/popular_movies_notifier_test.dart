import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/popular_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesNotifier provider;
  late MockGetPopularMovies mockGetPopularMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockGetPopularMovies = MockGetPopularMovies();

    provider = PopularMoviesNotifier(getPopularMovies: mockGetPopularMovies)
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
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));

    // act
    provider.fetchPopularMovies();

    // assert
    expect(provider.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('Should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));

    // act
    await provider.fetchPopularMovies();

    // assert
    expect(provider.state, RequestState.loaded);
    expect(provider.movies, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('Should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

    // act
    await provider.fetchPopularMovies();

    // assert
    expect(provider.state, RequestState.error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
