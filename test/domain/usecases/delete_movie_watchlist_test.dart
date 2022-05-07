import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie_usecases/delete_movie_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late DeleteMovieWatchlist usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = DeleteMovieWatchlist(mockMovieRepository);
  });

  test('Should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.deleteMovieWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed Movie from watchlist'));

    // act
    final result = await usecase.execute(testMovieDetail);

    // assert
    verify(mockMovieRepository.deleteMovieWatchlist(testMovieDetail));

    expect(result, const Right('Removed Movie from watchlist'));
  });
}
