import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late GetTvShowDetail usecase;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowDetail(mockTvShowRepository);
  });

  const tId = 1;

  test('Should get tv show detail from the repository', () async {
    // arrange
    when(mockTvShowRepository.getTvShowDetail(tId))
        .thenAnswer((_) async => const Right(testTvShowDetail));

    // act
    final result = await usecase.execute(tId);

    // assert
    expect(result, const Right(testTvShowDetail));
  });
}
