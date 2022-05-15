import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late GetTvShowWatchListStatus usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowWatchListStatus(mockTvShowRepository);
  });

  test('Should get tv show watchlist status from repository', () async {
    // arrange
    when(mockTvShowRepository.isTvShowAddedToWatchlist(1))
        .thenAnswer((_) async => const Right(true));

    // act
    final result = await usecase.execute(1);

    // assert
    expect(result, const Right(true));
  });
}
