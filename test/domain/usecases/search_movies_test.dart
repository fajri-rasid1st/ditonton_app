import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/search_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late SearchMovies usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  const tQuery = 'Spiderman';
  final tMovies = <Movie>[];

  test(
    'Should get list of movies from the repository according to query',
    () async {
      // arrange
      when(mockMovieRepository.searchMovies(tQuery))
          .thenAnswer((_) async => Right(tMovies));

      // act
      final result = await usecase.execute(tQuery);

      // assert
      expect(result, Right(tMovies));
    },
  );
}
