import 'package:ditonton/data/models/tv_show_models/tv_show_model.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';

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
