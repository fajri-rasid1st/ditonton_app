import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late SearchTvShows usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvShows(mockTvShowRepository);
  });

  const tQuery = 'Peaky Blinders';
  final tTvShows = <TvShow>[];

  test(
    'Should get list of tv shows from the repository according to query',
    () async {
      // arrange
      when(mockTvShowRepository.searchTvShows(tQuery))
          .thenAnswer((_) async => Right(tTvShows));

      // act
      final result = await usecase.execute(tQuery);

      // assert
      expect(result, Right(tTvShows));
    },
  );
}
