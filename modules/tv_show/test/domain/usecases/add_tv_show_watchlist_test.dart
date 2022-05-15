import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late AddTvShowWatchlist usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = AddTvShowWatchlist(mockTvShowRepository);
  });

  test('Should add tv show to the repository', () async {
    // arrange
    when(mockTvShowRepository.addTvShowWatchlist(testTvShowDetail))
        .thenAnswer((_) async => const Right('Added Tv Show to Watchlist'));

    // act
    final result = await usecase.execute(testTvShowDetail);

    // assert
    verify(mockTvShowRepository.addTvShowWatchlist(testTvShowDetail));

    expect(result, const Right('Added Tv Show to Watchlist'));
  });
}
