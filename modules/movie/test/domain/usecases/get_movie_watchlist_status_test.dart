import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetMovieWatchListStatus usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieWatchListStatus(mockMovieRepository);
  });

  test('Should get movie watchlist status from repository', () async {
    // arrange
    when(mockMovieRepository.isMovieAddedToWatchlist(1))
        .thenAnswer((_) async => const Right(true));

    // act
    final result = await usecase.execute(1);

    // assert
    expect(result, const Right(true));
  });
}
