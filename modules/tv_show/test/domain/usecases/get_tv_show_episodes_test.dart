import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRpository;
  late GetTvShowEpisodes usecase;

  setUp(() {
    mockTvShowRpository = MockTvShowRepository();
    usecase = GetTvShowEpisodes(mockTvShowRpository);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  final tEpisodes = <Episode>[];

  test('Should get list of episodes from the repository', () async {
    // arrange
    when(mockTvShowRpository.getTvShowEpisodes(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(tEpisodes));

    // act
    final result = await usecase.execute(tId, tSeasonNumber);

    // assert
    expect(result, Right(tEpisodes));
  });
}
