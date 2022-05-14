import 'package:ditonton/data/models/movie_models/movie_model.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieModel = MovieModel(
    id: 1,
    title: 'title',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  const tMovie = Movie(
    id: 1,
    title: 'title',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  test('Should be a subclass of Movie entity', () async {
    final result = tMovieModel.toEntity();

    expect(result, tMovie);
  });
}
