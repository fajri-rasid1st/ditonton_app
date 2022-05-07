import 'dart:convert';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/data/datasources/tv_show_datasources/tv_show_remote_data_source.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late TvShowRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvShowRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get on the air tv shows', () {
    final tTvShowList = TvShowResponse.fromJson(
      json.decode(readJson('dummy_data/on_the_air_tv_shows.json')),
    ).tvShows;

    test(
      'Should return list of tv shows when response is success (code 200)',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/tv/on_the_air?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/on_the_air_tv_shows.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.getOnTheAirTvShows();

        // assert
        expect(result, equals(tTvShowList));
      },
    );

    test(
      'Should throw a ServerException when the response code is 404',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/tv/on_the_air?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getOnTheAirTvShows();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get popular tv shows', () {
    final tTvShowList = TvShowResponse.fromJson(
      json.decode(readJson('dummy_data/popular_tv_shows.json')),
    ).tvShows;

    test(
      'Should return list of tv shows when response is success (code 200)',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/tv/popular?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/popular_tv_shows.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.getPopularTvShows();

        // assert
        expect(result, tTvShowList);
      },
    );

    test(
      'Should throw a ServerException when the response code is 404',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/tv/popular?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getPopularTvShows();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get top rated tv shows', () {
    final tTvShowList = TvShowResponse.fromJson(
      json.decode(readJson('dummy_data/top_rated_tv_shows.json')),
    ).tvShows;

    test(
      'Should return list of tv shows when response is success (code 200)',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/tv/top_rated?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/top_rated_tv_shows.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.getTopRatedTvShows();

        // assert
        expect(result, tTvShowList);
      },
    );

    test(
      'Should throw a ServerException when the response code is 404',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/tv/top_rated?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getTopRatedTvShows();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get tv show detail', () {
    const tId = 1;

    final tTvShowDetail = TvShowDetailModel.fromJson(
      json.decode(readJson('dummy_data/tv_show_detail.json')),
    );

    test(
      'Should return tv show detail when the response code is 200',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/tv/$tId?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_show_detail.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.getTvShowDetail(tId);

        // assert
        expect(result, equals(tTvShowDetail));
      },
    );

    test(
      'Should throw Server Exception when the response code is 404',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/tv/$tId?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getTvShowDetail(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get tv show recommendations', () {
    const tId = 1;

    final tTvShowList = TvShowResponse.fromJson(
      json.decode(readJson('dummy_data/tv_show_recommendations.json')),
    ).tvShows;

    test(
      'Should return list of Tv Show Model when the response code is 200',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_show_recommendations.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.getTvShowRecommendations(tId);

        // assert
        expect(result, equals(tTvShowList));
      },
    );

    test(
      'Should throw Server Exception when the response code is 404',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getTvShowRecommendations(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Search tv shows', () {
    const tQuery = 'Peaky Blinders';

    final tSearchResult = TvShowResponse.fromJson(
      json.decode(readJson('dummy_data/search_peaky_blinders_tv_show.json')),
    ).tvShows;

    test(
      'Should return list of tv shows when response code is 200',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/search/tv?query=$tQuery&$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/search_peaky_blinders_tv_show.json'),
            200,
          ),
        );

        // act
        final result = await dataSource.searchTvShows(tQuery);

        // assert
        expect(result, tSearchResult);
      },
    );

    test(
      'Should throw ServerException when response code is other than 200',
      () async {
        // arrange
        final uri = Uri.parse('$baseUrl/search/tv?query=$tQuery&$apiKey');

        when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.searchTvShows(tQuery);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
