import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';

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
