import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_popular_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRpository;
  late GetPopularMovies usecase;

  setUp(() {
    mockMovieRpository = MockMovieRepository();
    usecase = GetPopularMovies(mockMovieRpository);
  });

  final tMovies = <Movie>[];

  test('Should get list of popular movies from the repository', () async {
    // arrange
    when(mockMovieRpository.getPopularMovies())
        .thenAnswer((_) async => Right(tMovies));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, Right(tMovies));
  });
}
