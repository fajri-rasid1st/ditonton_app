import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../helpers/test_helper.mocks.dart';

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
