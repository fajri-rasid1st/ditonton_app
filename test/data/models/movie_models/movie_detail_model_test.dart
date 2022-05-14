import 'dart:convert';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tMovieDetailModel = MovieDetailModel(
    genres: [GenreModel(name: 'Action')],
    id: 1,
    overview: 'Overview',
    posterPath: '/path.jpg',
    runtime: 120,
    title: 'Title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('fromJson', () {
    test('Should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/movie_detail.json'));

      // act
      final result = MovieDetailModel.fromJson(jsonMap);

      // assert
      expect(result, tMovieDetailModel);
    });
  });

  group('toJson', () {
    test('Should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieDetailModel.toJson();

      // assert
      final expectedJsonMap = {
        'genres': [
          {'name': 'Action'}
        ],
        'id': 1,
        'overview': 'Overview',
        'poster_path': '/path.jpg',
        'runtime': 120,
        'title': 'Title',
        'vote_average': 1.0,
        'vote_count': 1,
      };

      expect(result, expectedJsonMap);
    });
  });
}
