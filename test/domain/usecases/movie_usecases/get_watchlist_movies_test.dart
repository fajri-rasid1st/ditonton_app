import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetWatchlistMovies usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlistMovies(mockMovieRepository);
  });

  test('Should get list of watchlist movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getWatchlistMovies())
        .thenAnswer((_) async => const Right(testMovieList));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, const Right(testMovieList));
  });
}
