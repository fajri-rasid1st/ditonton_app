import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_popular_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRpository;
  late GetPopularTvShows usecase;

  setUp(() {
    mockTvShowRpository = MockTvShowRepository();
    usecase = GetPopularTvShows(mockTvShowRpository);
  });

  final tTvShows = <TvShow>[];

  test('Should get list of popular tv shows from the repository', () async {
    // arrange
    when(mockTvShowRpository.getPopularTvShows())
        .thenAnswer((_) async => Right(tTvShows));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, Right(tTvShows));
  });
}
