import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetMovieDetail usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieDetail(mockMovieRepository);
  });

  const tId = 1;

  test('Should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetail(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));

    // act
    final result = await usecase.execute(tId);

    // assert
    expect(result, const Right(testMovieDetail));
  });
}
