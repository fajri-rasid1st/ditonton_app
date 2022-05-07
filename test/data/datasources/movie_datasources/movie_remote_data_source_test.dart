import 'dart:convert';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/data/datasources/movie_datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/models/movie_models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_models/movie_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late MovieRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get now playing movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/now_playing_movies.json')),
    ).movies;

    test(
      'Should return list of movies when response is success (code 200)',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/movie/now_playing?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/now_playing_movies.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.getNowPlayingMovies();

        // assert
        expect(result, equals(tMovieList));
      },
    );

    test(
      'Should throw a ServerException when the response code is 404',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/movie/now_playing?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getNowPlayingMovies();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get popular movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/popular_movies.json')),
    ).movies;

    test(
      'Should return list of movies when response is success (code 200)',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/movie/popular?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/popular_movies.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.getPopularMovies();

        // assert
        expect(result, tMovieList);
      },
    );

    test(
      'Should throw a ServerException when the response code is 404',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/movie/popular?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getPopularMovies();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get top rated movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/top_rated_movies.json')),
    ).movies;

    test(
      'Should return list of movies when response is success (code 200)',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/movie/top_rated?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/top_rated_movies.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.getTopRatedMovies();

        // assert
        expect(result, tMovieList);
      },
    );

    test(
      'Should throw a ServerException when the response code is 404',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/movie/top_rated?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getTopRatedMovies();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get movie detail', () {
    const tId = 1;

    final tMovieDetail = MovieDetailModel.fromJson(
      json.decode(readJson('dummy_data/movie_detail.json')),
    );

    test(
      'Should return movie detail when the response code is 200',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/movie/$tId?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/movie_detail.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.getMovieDetail(tId);

        // assert
        expect(result, equals(tMovieDetail));
      },
    );

    test(
      'Should throw Server Exception when the response code is 404',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/movie/$tId?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getMovieDetail(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get movie recommendations', () {
    const tId = 1;

    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/movie_recommendations.json')),
    ).movies;

    test(
      'Should return list of Movie Model when the response code is 200',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/movie/$tId/recommendations?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/movie_recommendations.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.getMovieRecommendations(tId);

        // assert
        expect(result, equals(tMovieList));
      },
    );

    test(
      'Should throw Server Exception when the response code is 404',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/movie/$tId/recommendations?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getMovieRecommendations(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Search movies', () {
    const tQuery = 'Spiderman';

    final tSearchResult = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/search_spiderman_movie.json')),
    ).movies;

    test(
      'Should return list of movies when response code is 200',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/search/movie?query=$tQuery&$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/search_spiderman_movie.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.searchMovies(tQuery);

        // assert
        expect(result, tSearchResult);
      },
    );

    test(
      'Should throw ServerException when response code is other than 200',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/search/movie?query=$tQuery&$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.searchMovies(tQuery);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
