import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late DeleteTvShowWatchlist usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = DeleteTvShowWatchlist(mockTvShowRepository);
  });

  test('Should remove watchlist tv show from repository', () async {
    // arrange
    when(mockTvShowRepository.deleteTvShowWatchlist(testTvShowDetail))
        .thenAnswer((_) async => const Right('Removed tv show from watchlist'));

    // act
    final result = await usecase.execute(testTvShowDetail);

    // assert
    verify(mockTvShowRepository.deleteTvShowWatchlist(testTvShowDetail));

    expect(result, const Right('Removed tv show from watchlist'));
  });
}
