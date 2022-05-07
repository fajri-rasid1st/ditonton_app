import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late GetTvShowRecommendations usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowRecommendations(mockTvShowRepository);
  });

  const tId = 1;
  final tTvShows = <TvShow>[];

  test(
    'Should get list of tv show recommendations from the repository',
    () async {
      // arrange
      when(mockTvShowRepository.getTvShowRecommendations(tId))
          .thenAnswer((_) async => Right(tTvShows));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, Right(tTvShows));
    },
  );
}
