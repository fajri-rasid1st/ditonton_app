import 'package:flutter_test/flutter_test.dart';
import 'package:tv_show/tvshow.dart';

void main() {
  const tTvShowModel = TvShowModel(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  const tTvShow = TvShow(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  test('Should be a subclass of Tv Show entity', () async {
    final result = tTvShowModel.toEntity();

    expect(result, tTvShow);
  });
}
