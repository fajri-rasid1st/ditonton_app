import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../helpers/test_helper.mocks.dart';

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
