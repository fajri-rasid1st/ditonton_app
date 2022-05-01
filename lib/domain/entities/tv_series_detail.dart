import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  final String backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String overview;
  final String posterPath;
  final List<Season> seasons;
  final double voteAverage;
  final int voteCount;

  const TvSeriesDetail({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        overview,
        posterPath,
        seasons,
        voteAverage,
        voteCount,
      ];
}
