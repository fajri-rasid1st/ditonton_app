import 'package:ditonton/data/models/movie_models/movie_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';
// import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';

// Movie dummy objects
const testMovie = Movie(
  id: 557,
  title: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
);

const testMovieList = <Movie>[testMovie];

const testMovieDetail = MovieDetail(
  genres: [Genre(name: 'Action')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

const testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

// Tv show dummy objects
// const testTvShow = TvShow(
//   id: 1399,
//   name: "Game of Thrones",
//   overview:
//       "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
//   posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
// );

// const testTvShowList = [testTvShow];
