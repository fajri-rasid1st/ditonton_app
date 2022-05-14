import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_on_the_air_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late GetOnTheAirTvShows usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetOnTheAirTvShows(mockTvShowRepository);
  });

  final tTvShows = <TvShow>[];

  test('Should get list of on the air tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getOnTheAirTvShows())
        .thenAnswer((_) async => Right(tTvShows));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, Right(tTvShows));
  });
}
