import 'dart:convert';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tTvShowDetailModel = TvShowDetailModel(
    firstAirDate: '2011-04-17',
    genres: [GenreModel(name: 'Sci-Fi & Fantasy')],
    id: 1399,
    lastAirDate: '2019-05-19',
    name: 'Game of Thrones',
    numberOfEpisodes: 73,
    numberOfSeasons: 8,
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
    seasons: [
      SeasonModel(
        airDate: '2010-12-05',
        episodeCount: 240,
        name: 'Specials',
        overview: '',
        posterPath: '/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg',
        seasonNumber: 0,
      )
    ],
    voteAverage: 8.4,
    voteCount: 17807,
  );

  group('fromJson', () {
    test('Should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_show_detail.json'));

      // act
      final result = TvShowDetailModel.fromJson(jsonMap);

      // assert
      expect(result, tTvShowDetailModel);
    });
  });

  group('toJson', () {
    test('Should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvShowDetailModel.toJson();

      // assert
      final expectedJsonMap = {
        'first_air_date': '2011-04-17',
        'genres': [
          {'name': 'Sci-Fi & Fantasy'}
        ],
        'id': 1399,
        'last_air_date': '2019-05-19',
        'name': 'Game of Thrones',
        'number_of_episodes': 73,
        'number_of_seasons': 8,
        'overview':
            "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
        'poster_path': '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
        'seasons': [
          {
            'air_date': '2010-12-05',
            'episode_count': 240,
            'name': 'Specials',
            'overview': '',
            'poster_path': '/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg',
            'season_number': 0,
          }
        ],
        'vote_average': 8.4,
        'vote_count': 17807,
      };

      expect(result, expectedJsonMap);
    });
  });
}
