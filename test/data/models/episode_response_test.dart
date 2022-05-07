import 'dart:convert';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/episode_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
    airDate: "2013-09-12",
    episodeNumber: 1,
    name: "Episode 1",
    overview:
        "Birmingham, 1919. Thomas Shelby controls the Peaky Blinders, one of the city's most feared criminal organisations, but his ambitions go beyond running the streets. When a crate of guns goes missing, Thomas recognises an opportunity to move up in the world.",
    stillPath: "/tplu6cXP312IN5rrT5K81zFZpMd.jpg",
  );

  const tEpisodeResponseModel = EpisodeResponse(
    episodes: <EpisodeModel>[tEpisodeModel],
  );

  group('fromJson', () {
    test('Should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_show_season_detail.json'));

      // act
      final result = EpisodeResponse.fromJson(jsonMap);

      // assert
      expect(result, tEpisodeResponseModel);
    });
  });

  group('toJson', () {
    test('Should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tEpisodeResponseModel.toJson();

      // assert
      final expectedJsonMap = {
        "episodes": [
          {
            "air_date": "2013-09-12",
            "episode_number": 1,
            "name": "Episode 1",
            "overview":
                "Birmingham, 1919. Thomas Shelby controls the Peaky Blinders, one of the city's most feared criminal organisations, but his ambitions go beyond running the streets. When a crate of guns goes missing, Thomas recognises an opportunity to move up in the world.",
            "still_path": "/tplu6cXP312IN5rrT5K81zFZpMd.jpg"
          }
        ],
      };

      expect(result, expectedJsonMap);
    });
  });
}
