import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_watchlist_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late GetWatchlistTvShows usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetWatchlistTvShows(mockTvShowRepository);
  });

  test('Should get list of watchlist tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getWatchlistTvShows())
        .thenAnswer((_) async => const Right(testTvShowList));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, const Right(testTvShowList));
  });
}
