import 'package:core/domain/entities/genre.dart';
import 'package:movie/movie.dart';

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
  genres: <Genre>[Genre(name: 'Action')],
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
  overview: 'overview',
  posterPath: 'posterPath',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  overview: 'overview',
  posterPath: 'posterPath',
  createdAt: DateTime.utc(1969, 7, 20, 20, 18, 04),
);

const testMovieMap = {
  'id': 1,
  'title': 'title',
  'overview': 'overview',
  'posterPath': 'posterPath',
};
