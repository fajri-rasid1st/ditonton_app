import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetMovieRecommendations usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieRecommendations(mockMovieRepository);
  });

  const tId = 1;
  final tMovies = <Movie>[];

  test(
    'Should get list of movie recommendations from the repository',
    () async {
      // arrange
      when(mockMovieRepository.getMovieRecommendations(tId))
          .thenAnswer((_) async => Right(tMovies));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, Right(tMovies));
    },
  );
}