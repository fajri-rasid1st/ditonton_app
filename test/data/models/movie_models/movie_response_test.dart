import 'dart:convert';
import 'package:ditonton/data/models/movie_models/movie_model.dart';
import 'package:ditonton/data/models/movie_models/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tMovieModel = MovieModel(
    id: 1,
    title: 'Title',
    overview: 'Overview',
    posterPath: '/path.jpg',
  );

  const tMovieResponseModel = MovieResponse(movies: <MovieModel>[tMovieModel]);

  group('fromJson', () {
    test('Should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_movies.json'));

      // act
      final result = MovieResponse.fromJson(jsonMap);

      // assert
      expect(result, tMovieResponseModel);
    });
  });

  group('toJson', () {
    test('Should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieResponseModel.toJson();

      // assert
      final expectedJsonMap = {
        'results': [
          {
            'id': 1,
            'title': 'Title',
            'overview': 'Overview',
            'poster_path': '/path.jpg'
          }
        ],
      };

      expect(result, expectedJsonMap);
    });
  });
}
