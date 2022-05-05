import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';

class TvShowDetail extends Equatable {
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String overview;
  final String posterPath;
  final List<Season> seasons;
  final double voteAverage;
  final int voteCount;

  const TvShowDetail({
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.lastAirDate,
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
        firstAirDate,
        genres,
        id,
        lastAirDate,
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
