import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie_usecases/add_movie_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late AddMovieWatchlist usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = AddMovieWatchlist(mockMovieRepository);
  });

  test('Should add movie to the repository', () async {
    // arrange
    when(mockMovieRepository.addMovieWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Added Movie to Watchlist'));

    // act
    final result = await usecase.execute(testMovieDetail);

    // assert
    verify(mockMovieRepository.addMovieWatchlist(testMovieDetail));

    expect(result, const Right('Added Movie to Watchlist'));
  });
}
