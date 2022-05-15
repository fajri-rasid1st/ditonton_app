import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_show/tvshow.dart';

import '../../json_reader.dart';

void main() {
  const tTvShowModel = TvShowModel(
    id: 52814,
    name: 'Halo',
    overview:
        'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
    posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
  );

  const tTvShowResponseModel = TvShowResponse(
    tvShows: <TvShowModel>[tTvShowModel],
  );

  group('fromJson', () {
    test('Should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air_tv_shows.json'));

      // act
      final result = TvShowResponse.fromJson(jsonMap);

      // assert
      expect(result, tTvShowResponseModel);
    });
  });

  group('toJson', () {
    test('Should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvShowResponseModel.toJson();

      // assert
      final expectedJsonMap = {
        'results': [
          {
            'id': 52814,
            'name': 'Halo',
            'overview':
                'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
            'poster_path': '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg'
          }
        ],
      };

      expect(result, expectedJsonMap);
    });
  });
}
