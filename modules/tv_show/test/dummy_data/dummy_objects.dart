import 'package:core/domain/entities/genre.dart';
import 'package:tv_show/tvshow.dart';

// Tv show dummy objects
const testTvShow = TvShow(
  id: 1399,
  name: "Game of Thrones",
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
);

const testTvShowList = <TvShow>[testTvShow];

const testTvShowDetail = TvShowDetail(
  firstAirDate: '2011-04-17',
  genres: <Genre>[Genre(name: 'Action')],
  id: 1,
  lastAirDate: '2019-05-19',
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: <Season>[
    Season(
      airDate: '2011-04-17',
      episodeCount: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    )
  ],
  voteAverage: 1,
  voteCount: 1,
);

const testWatchlistTvShow = TvShow.watchlist(
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
);

final testTvShowTable = TvShowTable(
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  createdAt: DateTime.utc(1969, 7, 20, 20, 18, 04),
);

const testTvShowMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};

// Season dummy object
const testSeason = Season(
  airDate: '2011-04-17',
  episodeCount: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

// Episode dummy object
const testEpisode = Episode(
  airDate: '2013-09-12',
  episodeNumber: 1,
  name: 'name',
  overview: 'overview',
  stillPath: 'stillPath',
);

const testEpisodeList = <Episode>[testEpisode];
